import about
import contact
import grille_pain
import grille_pain/lustre/toast
import home
import lustre
import lustre/attribute
import lustre/effect.{type Effect}
import lustre/event
import projects
import sketch.{type StyleSheet}
import sketch/css
import sketch/css/length
import sketch/lustre as sketch_lustre
import sketch/lustre/element.{type Element}
import sketch/lustre/element/html
import styles
import icon/icon
import icon/icon_wrapper

import message.{type Msg}
import model.{type Model}

fn watch_scheme() -> Effect(Msg) {
  effect.from(fn(dispatch) {
    use is_dark <- styles.on_scheme_change
    dispatch(message.SystemThemeChanged(is_dark))
  })
}

@external(javascript, "./browser_ffi.mjs", "onResize")
fn on_resize(dispatch: fn(Int) -> Nil) -> Nil

@external(javascript, "./browser_ffi.mjs", "getWindowWidth")
fn get_window_width() -> Int

fn init(_) -> #(Model, Effect(Msg)) {
  #(
    model.Model(
        colour_mode: model.System(styles.prefers_dark()),
        layout: case get_window_width() {
            // magic value for now
            w if w <= 750 -> model.Mobile(False)
            _ -> model.Desktop
        }
    ),
    effect.batch([
      watch_scheme(),
      effect.from(fn(dispatch) {
        use w <- on_resize
        dispatch(message.UserResizedWindow(w))
      }),
    ]),
  )
}

fn update(model: Model, msg: Msg) -> #(Model, Effect(Msg)) {
  echo model
  case msg {
      message.UserToggledColourMode -> #(
      model.Model(..model, colour_mode: case model.colour_mode {
          model.Light | model.System(False) -> {
          styles.set_attribute("data-theme", "dark")
          model.Dark
        }
        model.Dark | model.System(True) -> {
          styles.set_attribute("data-theme", "light")
          model.Light
        }
      }),
      effect.none(),
    )
    message.SystemThemeChanged(is_dark:) -> #(
      model.Model(..model, colour_mode: case is_dark {
        True -> model.Dark
        False -> model.Light
      }),
      effect.none(),
    )
    message.UserPressedEmail -> {
      contact.write_text("oslewei.proton.me")
      #(model, toast.toast("Copied Email!"))
    }
    message.UserResizedWindow(window_width) -> {
    #(model.Model(..model, layout: case window_width {
      w if w <= 750 -> model.Mobile(False)
      _ -> model.Desktop
    }), effect.none())
    }
    // we are assuming that these messages only work when in mobile
    // this may be a strong assumptio
    message.UserOpenedHamburger -> #(
        model.Model(..model, layout: model.Mobile(True)),
      effect.none(),
    )
    message.UserClosedHamburger -> #(
        model.Model(..model, layout: model.Mobile(False)),
      effect.none(),
    )
  }
}

fn light_mode_button(model: Model) -> Element(Msg) {
    html.button(styles.button(), [event.on_click(message.UserToggledColourMode)], [
    case model.colour_mode {
        model.Light | model.System(False) -> icon_wrapper.icon(styles.icon(), [], icon.moon)
      model.Dark | model.System(True) -> icon_wrapper.icon(styles.icon(), [], icon.sun)
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
      case model.layout {
          model.Desktop ->
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
      model.Mobile(hamburger) ->
        case hamburger {
          False ->
            html.button_([event.on_click(message.UserOpenedHamburger)], [
              icon_wrapper.icon(styles.icon(), [], icon.hamburger),
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
                [event.on_click(message.UserClosedHamburger)],
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
