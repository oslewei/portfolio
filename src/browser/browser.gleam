import gleam/javascript/promise.{type Promise}

@external(javascript, "./browser_ffi.mjs", "readText")
pub fn read_text() -> Promise(Result(String, String))

@external(javascript, "./browser_ffi.mjs", "writeText")
pub fn write_text(clip_text: String) -> Promise(Result(Nil, String))

@external(javascript, "./browser_ffi.mjs", "onResize")
pub fn on_resize(dispatch: fn(Int) -> Nil) -> Nil

@external(javascript, "./browser_ffi.mjs", "getWindowWidth")
pub fn get_window_width() -> Int

@external(javascript, "./browser_ffi.mjs", "loremIpsumGleam")
pub fn lorem_ipsum(count: Int, units: String) -> String

@external(javascript, "./browser_ffi.mjs", "setAttribute")
pub fn set_attribute(attrib: String, state: String) -> Nil

@external(javascript, "./browser_ffi.mjs", "prefersDark")
pub fn prefers_dark() -> Bool

@external(javascript, "./browser_ffi.mjs", "onSchemeChange")
pub fn on_scheme_change(callback: fn(Bool) -> Nil) -> Nil
