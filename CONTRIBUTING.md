# Contributing

- [Code of Conduct](#code-of-conduct)
- [Overview](#overview)
- [Building](#building)
  - [Native](#native)
  - [Just the WebAssembly](#just-the-webassembly)
  - [WebAssembly and JavaScript Bundle](#webassembly-and-javascript-bundle)
  - [Cargo Features](#cargo-features)
- [Serving Locally with Webpack](#serving-locally-with-webpack)
- [Testing](#testing)
- [Benchmarking](#benchmarking)
- [Code Formatting](#code-formatting)

## Code of Conduct

We abide by the [Rust Code of
Conduct](https://www.rust-lang.org/en-US/conduct.html) and ask that you do as
well.

## Overview

* `src/lib.rs`: Main entry point for the Rust crate.

* `index.html`: Root HTML page that loads the JS and Wasm.

* `index.js`: Root JS module, imports the `wasm-bindgen`-generated JS interface
  to the Rust's Wasm, and transitively loads the Wasm itself.

* `tests/`: Rust tests for native code.

* `benches/`: Rust benchmarks for native code.

* `webpack.config.js`: Webpack configuration.

* `ci/`: Continuous integration scripts.

## Building

### Native

To build the crate for the native target, run

```
cargo build
```

or

```
cargo build --release
```

### Just the WebAssembly

To build just the `.wasm` binary, run

```
cargo build --target wasm32-unknown-unknown
```

or

```
cargo build --target wasm32-unknown-unknown --release
```

### WebAssembly and JavaScript Bundle

First, ensure that you've installed Webpack locally by running this command
within the repository:

```
npm install
```

Then, to build the optimized WebAssembly, the `wasm-bindgen` JS interface to it,
and the JavaScript bundle using the JS interface, run:

```
npm run build
```

### Cargo Features

* `wee_alloc`: Enable using [`wee_alloc`](https://github.com/rustwasm/wee_alloc)
  as the global allocator. This trades allocation speed for smaller code size.

* `console_error_panic_hook`: Enable better debugging of panics by printing
  error messages in browser devtools with `console.error`.

## Serving Locally with Webpack

Ensure that you have installed Webpack and its development server by running
this command within the repository:

```
npm install
```

After that, you can start a local server on
[http://localhost:8080](http://localhost:8080) by running this command:

```
npm run serve
```

## Testing

There are integration tests in the `tests/` directory, and unit tests in
`#[cfg(test)]` modules within the crate itself.

To run all the tests, run

```
cargo test
```

## Benchmarking

Benchmarks live within the `benches/` directory.

To run all benchmarks, run

```
cargo bench
```

## Code Formatting

Ensure that you have the `rustfmt-preview` component installed in `rustup`:

```
rustup component add rustup-preview
```

To format all of the code in the crate, run

```
cargo fmt
```
