import sketch/css/length

pub type ColourMode {
  // lazy but true is dark and false is light
  System(is_dark: Bool)
  Light
  Dark
}

pub type Model {
  Model(
    // TODO: fix this, I want to use types to make hamburger is open only work then
    // because the hamburger sholdnt even bw therer wthout
    hamburger_is_open: Bool,
    window_width: Int,
    colour_mode: ColourMode,
  )
}

pub type Msg {
  UserResizedWindow(width: Int)
  UserToggledColourMode
  UserPressedEmail
  SystemThemeChanged(is_dark: Bool)
  UserOpenedHamburger
  UserClosedHamburger
}

pub fn zero() {
  length.cm(0)
}

@external(javascript, "./browser_ffi.mjs", "loremIpsumGleam")
pub fn lorem_ipsum(count: Int, units: String) -> String
