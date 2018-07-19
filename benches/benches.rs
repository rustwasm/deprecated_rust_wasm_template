#![feature(test)]

extern crate {{crate_name}};
extern crate test;

use {{crate_name}}::Counter;

#[bench]
fn benches_in_the_benches_dir_work(b: &mut test::Bencher) {
    let mut c = Counter::new();
    b.iter(|| {
        c.increment();
    });
}
