//// global styles

import shared.{zero}
import sketch
import sketch/css
import sketch/css/length
import sketch/css/media

@external(javascript, "./browser_ffi.mjs", "setAttribute")
pub fn set_attribute(attrib: String, state: String) -> Nil

@external(javascript, "./browser_ffi.mjs", "prefersDark")
pub fn prefers_dark() -> Bool

@external(javascript, "./browser_ffi.mjs", "onSchemeChange")
pub fn on_scheme_change(callback: fn(Bool) -> Nil) -> Nil

// private colour values
const light_color = "#FAF9F6"
const dark_color = "#1A1A18"
const accent_color = "#8d1952"

// publically accessable variables
pub const var_bg_color = "var(--bg-color)"
pub const var_fg_color = "var(--fg-color)"
pub const var_ac_color = "var(--accent-color)"

pub fn icon() -> css.Class {
  css.class([
    css.color(var_fg_color),
  ])
}

pub fn section() -> css.Class {
  css.class([
    css.display("flex"),
    css.flex_direction("column"),
    css.justify_content("center"),
    css.align_items("center"),
    css.border("solid 1px black"),
    css.height(length.vh(100)),
  ])
}

pub fn button() -> css.Class {
  css.class([
    css.display("inline-block"),
    css.padding_left(length.rem(1.5)),
    css.padding_right(length.rem(1.5)),
    css.padding_top(length.rem(0.75)),
    css.padding_bottom(length.rem(0.75)),
    css.font_weight("500"),
    css.text_align("center"),
    css.background_color(var_bg_color),
    // css.transition("background-color 0.2s ease"),
    css.border("1px solid black"),

    css.hover([
      css.background_color(var_ac_color),
      css.border_color("black"),
    ]),

    css.active([css.background_color("#1e40af")]),
  ])
}

pub fn global(stylesheet: sketch.StyleSheet) -> sketch.StyleSheet {
  stylesheet
  |> sketch.global(
    css.global(":root", [
      css.font_family("\"IBM Plex Sans\", sans-serif"),
      css.scroll_behavior("smooth"),
      css.background_color(light_color),
      
      // the accent colour does not change for now
      css.property("--accent-color", accent_color),

      css.background_color(var_bg_color),
      css.color(var_fg_color),
      css.accent_color(var_ac_color),
    ]),
  )
  |> sketch.global(
    css.global("body", [
      css.overflow_x("hidden"),
      css.margin(zero()),
      css.padding(zero()),
    ]),
  )
  |> sketch.global(
    css.global("[data-theme=\"dark\"]", [
      css.property("--bg-color", dark_color),
      css.property("--fg-color", light_color),
    ]),
  )
  |> sketch.global(
    css.global("[data-theme=\"light\"]", [
      css.property("--bg-color", light_color),
      css.property("--fg-color", dark_color),
    ]),
  )
  |> sketch.global(
    css.global(":root:not([data-theme])", [
      css.property("--bg-color", light_color),
      css.property("--fg-color", dark_color),
      
      css.media(media.dark_theme(), [
        css.property("--bg-color", dark_color),
        css.property("--fg-color", light_color),
      ]),
    ])
  )
}
