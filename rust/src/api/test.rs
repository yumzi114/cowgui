#[flutter_rust_bridge::frb(sync)] 
pub fn hello(a: String) -> String { a.repeat(2) }



#[flutter_rust_bridge::frb(sync)] 
pub fn square(n: u32) -> u32 {
    n * n
}