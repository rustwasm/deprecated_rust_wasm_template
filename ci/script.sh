#!/usr/bin/env bash

set -eu

cd "$(dirname "$0")/.."

function main {
    case "$JOB" in
        "build")
            do_build
            ;;

        "test")
            do_test
            ;;

        "bench")
            do_bench
            ;;

        "wasm")
            do_wasm
            ;;

        *)
            echo "Error: unknown \$JOB = $JOB"
            exit 1
            ;;
    esac
}

function do_build {
    header 'Building'
    logged cargo \
           cargo +nightly build
    logged cargo \
           cargo +nightly build --release
}

function do_test {
    header 'Testing'

    logged cargo \
           cargo +nightly test           --no-default-features
    logged cargo \
           cargo +nightly test --release --no-default-features

    logged cargo \
           cargo +nightly test           --features wee_alloc
    logged cargo \
           cargo +nightly test --release --features wee_alloc
}

function do_bench {
    header 'Benchmarking'
    logged cargo \
           cargo +nightly bench
}

function do_wasm {
    header 'Updating rust nightly and installing the `wasm32-unknown-unknown` target.'

    logged rustup \
           rustup update nightly
    logged rustup \
           rustup target add wasm32-unknown-unknown --toolchain nightly

    header 'Building for `wasm32-unknown-unknown` target.'
    logged cargo \
           cargo +nightly build \
           --release \
           --target wasm32-unknown-unknown

    header 'Installing wasm-bindgen locally'
    ensure_wasm_bindgen_installed

    header 'Running wasm-bindgen'
    local target_wasm_file=$(ls ./target/wasm32-unknown-unknown/release/*.wasm)
    logged wasm-bindgen \
           ./bin/wasm-bindgen \
           --out-dir . \
           "$target_wasm_file"

    header 'Running wasm-opt'
    local local_wasm_file=$(ls *.wasm)
    if test -x "$(which wasm-opt | xargs)"; then
        local tmp=$(mktemp)
        logged wasm-opt \
               wasm-opt -Oz -o "$tmp" "$local_wasm_file"
        mv "$tmp" "$local_wasm_file"
    else
        echo 'Could not find a suitable `wasm-opt` on $PATH. Install'
        echo '`wasm-opt` from the `binaryen` suite to produce smaller'
        echo 'and faster `.wasm` binaries!'
        echo
        echo 'https://github.com/WebAssembly/binaryen'
    fi

    header 'Final `.wasm` Size'
    wc -c "$local_wasm_file"
}

function get_wasm_bindgen_version {
    # * Find the wasm-bindgen dependency in Cargo.toml
    #
    # * Split on the '=' in 'wasm-bindgen = "X.Y.Z"' and take the version number
    #   on the right hand side.
    #
    # * Replace the double quotes with spaces.
    #
    # * Trim whitespace.
    grep "wasm-bindgen =" Cargo.toml \
        | cut -d '=' -f 2 \
        | tr '"' ' ' \
        | xargs
}

function header {
    echo
    echo '================================================================================'
    for x in "$@"; do
        echo "$x"
    done
    echo '--------------------------------------------------------------------------------'
    echo
}

function ensure_wasm_bindgen_installed {
    local version=$(get_wasm_bindgen_version)
    local version_string="wasm-bindgen $version"

    if test -x ./bin/wasm-bindgen; then
        if test "$(./bin/wasm-bindgen --version | xargs)" == "$version_string"; then
            echo 'Correct version of wasm-bindgen already installed locally.'
            return
        fi

        echo "Wrong version installed locally, updating to $version."
    else
        echo 'wasm-bindgen not installed locally, installing.'
    fi

    logged cargo \
           cargo +nightly install -f wasm-bindgen-cli \
           --version "$version" \
           --root "$(pwd)"
}

function logged {
    local prefix="$1"
    shift
    echo "Running '$@'"
    "$@" > >(sed "s/^/$prefix: /") 2> >(sed "s/^/$prefix (stderr): /" >&2)
    echo
}

main
