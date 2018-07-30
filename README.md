<meta charset="utf-8"/>

**DEPRECATED**: Use rustwasm/wasm-pack-template for libraries and rustwasm/rust-webpack-template for webapps with webpack.

# Rust 🦀 and WebAssembly 🕸 Template 🏗

[![Build Status](https://travis-ci.org/rustwasm/rust_wasm_template.svg?branch=master)](https://travis-ci.org/rustwasm/rust_wasm_template)

This is a template to jump-start your Rust and WebAssembly project and let you
hit the ground running.

## 🛍 What's Inside?

* ✔ The latest [`wasm-bindgen`](https://github.com/rustwasm/wasm-bindgen) for
  light and seamless bidirectional communication between Rust and
  JavaScript. Import JavaScript things into Rust and export Rust things to
  JavaScript.

* ✔ Boilerplate for builds, optimizing, and post-processing:

  * ✔ Generates the JS interface to your `.wasm` binary with the appropriate
    `wasm-bindgen` invocation.

  * ✔ Runs [`wasm-opt`](https://github.com/WebAssembly/binaryen) to shrink the
    `.wasm` binary's code size and also speed it up at runtime.

  * ✔ Bundles your JS with [Webpack](https://webpack.js.org/).

* ✔ Serve your `.wasm` and JS locally with [Webpack's
  dev-server](https://github.com/webpack/webpack-dev-server/).

* ✔ Better debugging with [Rust panics forwarded to
  `console.error`](https://github.com/rustwasm/console_error_panic_hook).

* ✔ Optionally use [`wee_alloc`](https://github.com/rustwasm/wee_alloc) as the
  global allocator, to help keep your code size footprint small.

* ✔ Boilerplate for writing `#[test]`s and `#[bench]`es for the native target.

* ✔ Travis CI integration already set up. Make sure you never break your tests
  or your WebAssembly builds.

## 🤸 Using this Template

First, install `cargo-generate`:

```
cargo install cargo-generate
```

Second, generate a new project with this repository as a template:

```
cargo-generate --git https://github.com/rustwasm/rust_wasm_template.git
```

Answer the prompts and then you should be good to go! Check out your new
[`CONTRIBUTING.md`](./CONTRIBUTING.md) for details on building and project
organization.

### Enabling Travis CI

The Travis CI configuration is 100% pre-configured, and all you need to do is
[enable CI for the repo on your profile page](https://travis-ci.org/profile/).
