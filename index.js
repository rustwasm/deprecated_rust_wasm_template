import { Counter } from "./rust_wasm_template";

const c = Counter.new();
console.log(c.increment());
console.log(c.increment());
console.log(c.increment());
