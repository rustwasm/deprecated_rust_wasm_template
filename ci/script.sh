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

    # With no default features.
    logged cargo \
           cargo +nightly build           --no-default-features
    logged cargo \
           cargo +nightly build --release --no-default-features

    # With just the `wee_alloc` feature.
    logged cargo \
           cargo +nightly build           --no-default-features --features wee_alloc
    logged cargo \
           cargo +nightly build --release --no-default-features --features wee_alloc

    # With just the `console_error_panic_hook` feature.
    logged cargo \
           cargo +nightly build           --no-default-features --features console_error_panic_hook
    logged cargo \
           cargo +nightly build --release --no-default-features --features console_error_panic_hook

    # With default features.
    logged cargo \
           cargo +nightly build
    logged cargo \
           cargo +nightly build --release
}

function do_test {
    header 'Testing'

    # With no default features.
    logged cargo \
           cargo +nightly test           --no-default-features
    logged cargo \
           cargo +nightly test --release --no-default-features

    # With just the `wee_alloc` feature.
    logged cargo \
           cargo +nightly test           --no-default-features --features wee_alloc
    logged cargo \
           cargo +nightly test --release --no-default-features --features wee_alloc

    # With just the `console_error_panic_hook` feature.
    logged cargo \
           cargo +nightly test           --no-default-features --features console_error_panic_hook
    logged cargo \
           cargo +nightly test --release --no-default-features --features console_error_panic_hook

    # With default features.
    logged cargo \
           cargo +nightly test
    logged cargo \
           cargo +nightly test --release
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

    local local_wasm_file=$(ls *.wasm)

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
