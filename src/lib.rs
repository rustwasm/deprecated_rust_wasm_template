//! My awesome Rust and WebAssembly project!

#![feature(proc_macro, wasm_custom_section, wasm_import_module)]
#![cfg_attr(feature = "wee_alloc", feature(global_allocator))]

extern crate wasm_bindgen;
use wasm_bindgen::prelude::*;

// When the `wee_alloc` feature is enabled, use `wee_alloc` as the global
// allocator.
#[cfg(feature = "wee_alloc")]
extern crate wee_alloc;
#[cfg(feature = "wee_alloc")]
#[global_allocator]
static ALLOC: wee_alloc::WeeAlloc = wee_alloc::WeeAlloc::INIT;

/// My publicly exported type!
#[wasm_bindgen]
pub struct Counter {
    count: u32,
}

/// My publicly exported methods!
#[wasm_bindgen]
impl Counter {
    pub fn new() -> Counter {
        Counter { count: 0 }
    }

    pub fn increment(&mut self) -> u32 {
        let x = self.count;
        self.count += 1;
        x
    }
}

#[cfg(test)]
mod tests {
    #[test]
    fn tests_inside_the_crate_work() {
        assert_eq!(2 + 2, 4);
    }
}
