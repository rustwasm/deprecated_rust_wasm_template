#!/usr/bin/env bash

set -eux

cd "$(dirname "$0")/.."

function main {
    case "$JOB" in
        "build")
            cargo +nightly build
            cargo +nightly build --release
            ;;

        "test")
            cargo +nightly test
            cargo +nightly test --release
            ;;

        "bench")
            cargo +nightly bench
            ;;

        "wasm")
            rustup update nightly
            rustup target add wasm32-unknown-unknown --toolchain nightly

            cargo +nightly build --release --target wasm32-unknown-unknown

            ensure_wasm_bindgen_installed

            ./bin/wasm-bindgen --out-dir . ./target/wasm32-unknown-unknown/release/*.wasm
            wc -c *.wasm
            ;;

        *)
            echo "Error: unknown \$JOB = $JOB"
            exit 1
            ;;
    esac
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

function ensure_wasm_bindgen_installed {
    local version=$(get_wasm_bindgen_version)
    local version_string="wasm-bindgen $version"

    test -x ./bin/wasm-bindgen \
        && test "$(./bin/wasm-bindgen --version | xargs)" == "$version_string" \
            || cargo +nightly install -f wasm-bindgen-cli --version "$version" --root "$(pwd)"
}

main
