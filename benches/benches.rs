#![feature(test)]

extern crate rust_wasm_template;
extern crate test;

use rust_wasm_template::Counter;

#[bench]
fn benches_in_the_benches_dir_work(b: &mut test::Bencher) {
    let mut c = Counter::new();
    b.iter(|| {
        c.increment();
    });
}
