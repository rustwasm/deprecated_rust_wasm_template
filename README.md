<meta charset="utf-8"/>

# Rust 🦀 and WebAssembly 🕸 Template 🏗

[![Build Status](https://travis-ci.org/rustwasm/rust_wasm_template.svg?branch=master)](https://travis-ci.org/rustwasm/rust_wasm_template)

This is a template to jump-start your Rust and WebAssembly project and let you
hit the ground running.

## 🛍 What's Inside?

* [X] The latest `wasm-bindgen` so you can import JavaScript things into Rust
  and export Rust things to JavaScript.

* [X] Webpack bundling and dev-server integration.

* [X] (Optionally) using `wee_alloc` as the global allocator, to help keep your
  code size footprint small.

* [X] Boilerplate to build, optimize, and post-process your `.wasm` binaries.

* [X] Boilerplate for writing `#[test]`s and `#[bench]`es for the native target.

* [X] Travis CI integration to make sure you don't break your tests or your
  WebAssembly builds.

## 🤸 Using this Template

Clone the template repository:

```
git clone https://github.com/rustwasm/rust_wasm_template.git my_awesome_project
```

Replace all the references to the `rustwasm` github organization with your
github username or organization:

```
git ls-files | xargs sed -i -e 's/rustwasm/my_github_username/g'
```

Replace all the references to the `rust_wasm_template` and replace them with
`my_awesome_project` or whatever your awesome project is called:

```
git ls-files | xargs sed -i -e 's/rust_wasm_template/my_awesome_project/g'
```

For more details on building and testing, see [CONTRIBUTING.md](./CONTRIBUTING.md).
