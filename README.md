<meta charset="utf-8"/>

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

Clone the template repository:

```
git clone https://github.com/rustwasm/rust_wasm_template.git my_awesome_project
```

Replace all the references to the `rustwasm` github organization with your
github username or organization:

```
git ls-files | xargs sed -i '' -e 's/rustwasm/my_github_username/g'
```

Replace all the references to the `rust_wasm_template` and replace them with
`my_awesome_project` or whatever your awesome project is called:

```
git ls-files | xargs sed -i '' -e 's/rust_wasm_template/my_awesome_project/g'
```

For more details on building and testing, see [CONTRIBUTING.md](./CONTRIBUTING.md).

### Enabling Travis CI

The configuration is 100% configured, and all you need to do is [enable CI for
the repo on your profile page](https://travis-ci.org/profile/).
