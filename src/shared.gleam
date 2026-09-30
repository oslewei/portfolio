import sketch/css/length


pub fn zero() {
  length.cm(0)
}

@external(javascript, "./browser_ffi.mjs", "loremIpsumGleam")
pub fn lorem_ipsum(count: Int, units: String) -> String
