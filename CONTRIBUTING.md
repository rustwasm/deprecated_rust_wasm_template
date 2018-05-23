# Contributing

## Building

To build for the native target, run

```
cargo build
```

or

```
cargo build --release
```

To build the `.wasm` binary, run

```
JOB=wasm ./ci/script.sh
```

### Cargo Features

* `wee_alloc`: Enable using [`wee_alloc`](https://github.com/rustwasm/wee_alloc)
  as the global allocator. This trades allocation speed for smaller code size.

* `console_error_panic_hook`: Enable better debugging of panics by printing
  error messages in browser devtools with `console.error`.

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
