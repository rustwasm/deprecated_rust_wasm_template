//! My awesome Rust and WebAssembly project!

#![feature(proc_macro, wasm_custom_section, wasm_import_module)]
#![cfg_attr(feature = "wee_alloc", feature(global_allocator))]

#[macro_use]
extern crate cfg_if;

cfg_if! {
    // When the `console_error_panic_hook` feature is enabled, we can call the
    // `set_panic_hook` function to get better error messages if we ever panic.
    if #[cfg(feature = "console_error_panic_hook")] {
        extern crate console_error_panic_hook;
        use console_error_panic_hook::set_once as set_panic_hook;
    } else {
        #[inline]
        fn set_panic_hook() {}
    }
}

cfg_if! {
    // When the `wee_alloc` feature is enabled, use `wee_alloc` as the global
    // allocator.
    if #[cfg(feature = "wee_alloc")] {
        extern crate wee_alloc;
        #[global_allocator]
        static ALLOC: wee_alloc::WeeAlloc = wee_alloc::WeeAlloc::INIT;
    }
}

extern crate wasm_bindgen;
use wasm_bindgen::prelude::*;

/// My publicly exported type!
#[wasm_bindgen]
pub struct Counter {
    count: u32,
}

/// My publicly exported methods!
#[wasm_bindgen]
impl Counter {
    pub fn new() -> Counter {
        set_panic_hook();
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
