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
