import sketch/css/length
import lustre
import lustre/attribute
import lustre/effect.{type Effect}
import lustre/element.{type Element}
import sketch
import sketch/css
import sketch/lustre as sketch_lustre
import sketch/lustre/element/html
import styles

pub type Model {
  Model
}

pub type Msg {
  Msg
}

pub fn init(_flags) -> #(Model, Effect(Msg)) {
  #(Model, effect.none())
}

// I dont think afull one is necessary, maybe an islands architecture with a component
pub fn update(model: Model, _msg: Msg) -> #(Model, Effect(Msg)) {
  #(model, effect.none())
}

fn navbar() -> Element(msg) {
  html.nav(css.class([
    css.display("flex"),
    css.justify_content("space-between"),
    css.z_index(100),
    css.position("sticky"),
    css.top(length.px(0)),
    css.border_bottom("solid 1px black"),
    css.background(styles.var_bg_color),
  ]), [], [
    html.a(styles.button(), [attribute.href("/")], [
      html.text("Home")
    ]),
    html.a(styles.button(), [attribute.href("https://github.com/oslewei/zig-rtweekend")], [
      html.text("Github")
    ]),
  ])
}

pub fn view(_model: Model, stylesheet: sketch.StyleSheet) -> Element(Msg) {
  use <- sketch_lustre.render(stylesheet, [sketch_lustre.node()])
  html.div_([], [
    navbar(),
    html.main(css.class([
      css.display("flex"),
      css.flex_direction("column"),
      css.align_items("center")
    ]), [], [
      html.div_([], [html.h1_([], [html.text("Pathtracing in Zig")])]),
      html.img(css.class([
        css.width(length.px(800))
      ]), [
        attribute.src("/raytraced.png"),
      ]),
      html.h2_([], [html.text("Resources")]),
    ])
  ])
}

pub fn main() {
  let assert Ok(stylesheet) = sketch_lustre.construct(styles.global)
  let assert Ok(_) =
    lustre.application(init, update, view(_, stylesheet))
    |> lustre.start("#app", Nil)

  Nil
}
