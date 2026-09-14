import about
import contact
import grille_pain
import grille_pain/lustre/toast
import home
import lustre
import lustre/attribute
import lustre/effect.{type Effect}
import lustre/element.{type Element}
import lustre/event
import projects
import sketch.{type StyleSheet}
import sketch/css
import sketch/css/length
import sketch/lustre as sketch_lustre
import sketch/lustre/element/html
import styles
import icons/icons
import icons/icon_wrapper

import shared.{
  type Model, type Msg, Dark, Light, Model, System, SystemThemeChanged,
  UserClosedHamburger, UserOpenedHamburger, UserPressedEmail, UserResizedWindow,
  UserToggledColourMode,
}

fn watch_scheme() -> Effect(Msg) {
  effect.from(fn(dispatch) {
    use is_dark <- styles.on_scheme_change
    dispatch(SystemThemeChanged(is_dark))
  })
}

@external(javascript, "./browser_ffi.mjs", "onResize")
fn on_resize(dispatch: fn(Int) -> Nil) -> Nil

@external(javascript, "./browser_ffi.mjs", "getWindowWidth")
fn get_window_width() -> Int

fn init(_) -> #(Model, Effect(Msg)) {
  let width = get_window_width()
  #(
    // Change to user preference? 
    Model(
      window_width: width,
      hamburger_is_open: False,
      colour_mode: System(styles.prefers_dark()),
    ),
    effect.batch([
      watch_scheme(),
      effect.from(fn(dispatch) {
        use w <- on_resize
        dispatch(UserResizedWindow(w))
      }),
    ]),
  )
}

fn update(model: Model, msg: Msg) -> #(Model, Effect(Msg)) {
  case msg {
    UserToggledColourMode -> #(
      Model(..model, colour_mode: case model.colour_mode {
        Light | System(False) -> {
          styles.set_attribute("data-theme", "dark")
          Dark
        }
        Dark | System(True) -> {
          styles.set_attribute("data-theme", "light")
          Light
        }
      }),
      effect.none(),
    )
    SystemThemeChanged(is_dark:) -> #(
      Model(..model, colour_mode: case is_dark {
        True -> Dark
        False -> Light
      }),
      effect.none(),
    )
    UserPressedEmail -> {
      contact.write_text("oslewei.proton.me")
      #(model, toast.toast("Copied Email!"))
    }
    UserResizedWindow(window_width) -> {
      #(Model(..model, window_width:), effect.none())
    }
    UserOpenedHamburger -> #(
      Model(..model, hamburger_is_open: True),
      effect.none(),
    )
    UserClosedHamburger -> #(
      Model(..model, hamburger_is_open: False),
      effect.none(),
    )
  }
}

fn light_mode_button(model: Model) -> Element(Msg) {
  html.button(css.class([]), [event.on_click(UserToggledColourMode)], [
    case model.colour_mode {
      Light | System(False) -> icon_wrapper.icon(styles.icon(), [], icons.moon)
      Dark | System(True) -> icon_wrapper.icon(styles.icon(), [], icons.sun)
    },
  ])
}

fn navbar(model: Model) -> Element(Msg) {
  let nav_content = [
    html.a(styles.button(), [attribute.href("#home")], [html.text("home")]),
    html.a(styles.button(), [attribute.href("#about")], [html.text("about")]),
    html.a(styles.button(), [attribute.href("#projects")], [
      html.text("projects"),
    ]),
    html.a(styles.button(), [attribute.href("#contact")], [
      html.text("contact"),
    ]),
    light_mode_button(model),
  ]

  html.nav(css.class([
    css.z_index(100),
    css.position("sticky"),
    css.top(length.px(0)),
    css.border_bottom("solid 1px black"),
    css.background(styles.var_bg_color),
  ]), [], [
    case model.window_width > 500 {
      True ->
        html.div(
          css.class([
            css.width(length.vw(100)),
            css.display("flex"),
            css.flex_direction("row"),
            css.justify_content("space-between"),
            css.align_items("center"),
          ]),
          [],
          nav_content,
        )
      False ->
        case model.hamburger_is_open {
          False ->
            html.button_([event.on_click(UserOpenedHamburger)], [
              icon_wrapper.icon(styles.icon(), [], icons.hamburger),
            ])

          True ->
            html.div(css.class([css.z_index(100)]),
              [], [
              html.div(
                css.class([
                  css.position("fixed"),
                  css.inset("0"),
                  css.background("transparent"),
                  css.z_index(10),
                ]),
                [event.on_click(UserClosedHamburger)],
                [],
              ),
              html.div(
                css.class([
                  css.position("relative"),
                  css.display("flex"),
                  css.flex_direction("column"),
                  css.z_index(20),
                ]),
                [],
                nav_content,
              ),
            ])
        }
    },
  ])
}

fn view(model: Model, stylesheet: StyleSheet) -> Element(Msg) {
  use <- sketch_lustre.render(stylesheet, [sketch_lustre.node()])
  html.div(css.class([]), [], [
    navbar(model),
    html.section(styles.section(), [attribute.id("home")], home.view()),
    html.section(styles.section(), [attribute.id("about")], about.view()),
    html.section(styles.section(), [attribute.id("projects")], projects.view()),
    html.section(styles.section(), [attribute.id("contact")], contact.view()),
  ])
}

pub fn main() -> Nil {
  let assert Ok(stylesheet) = sketch_lustre.construct(styles.global)
  let assert Ok(_) = grille_pain.simple()
  let assert Ok(_) =
    lustre.application(init, update, view(_, stylesheet))
    |> lustre.start("#app", Nil)

  Nil
}
