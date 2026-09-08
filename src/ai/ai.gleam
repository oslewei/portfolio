import lustre
import lustre/effect.{type Effect}
import lustre/element.{type Element}
import shared
import sketch
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

pub fn update(model: Model, _msg: Msg) -> #(Model, Effect(Msg)) {
  #(model, effect.none())
}

pub fn view(_model: Model, stylesheet: sketch.StyleSheet) -> Element(Msg) {
  use <- sketch_lustre.render(stylesheet, [sketch_lustre.node()])
  html.div_([], [
    html.h1_([], [html.text("Deep Learning in C")]),
    html.p_([], [html.text(shared.lorem_ipsum(2, "paragraphs"))]),
  ])
}

pub fn main() {
  let assert Ok(stylesheet) = sketch_lustre.construct(styles.global)
  let assert Ok(_) =
    lustre.application(init, update, view(_, stylesheet))
    |> lustre.start("#app", Nil)

  Nil
}
