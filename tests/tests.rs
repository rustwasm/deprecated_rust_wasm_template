extern crate rust_wasm_template;

use rust_wasm_template::Counter;

#[test]
fn tests_in_the_tests_dir_work() {
    let mut c = Counter::new();
    assert_eq!(c.increment(), 0);
    assert_eq!(c.increment(), 1);
    assert_eq!(c.increment(), 2);
}
