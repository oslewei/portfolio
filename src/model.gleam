pub type ColourMode {
  // lazy but true is dark and false is light
  System(is_dark: Bool)
  Light
  Dark
}

pub type Layout {
  Desktop
  Mobile(is_hamburger_open: Bool)
}

pub type Model {
  Model(layout: Layout, colour_mode: ColourMode)
}
