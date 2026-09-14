import gleam/option.{type Option, None, Some}
import lustre/attribute
import lustre/element.{type Element}
import sketch/css
import sketch/css/length
import sketch/lustre/element/html
import styles

fn project_card(
  title: String,
  repository: String,
  showcase_link: Option(String),
) -> Element(message) {
  html.div(
    css.class([
      css.border("solid 1px black"),
      css.display("flex"),
      css.flex_direction("column"),
      css.align_items("center"),
    ]),
    [],
    [
      html.h1_([], [html.text(title)]),

      html.a(styles.button(), [attribute.href(repository)], [
        html.text("repository"),
      ]),
      // I dont like this about gleam, that you cant return nothing from a list
      ..{
        use link <- option.map(showcase_link)
        [
          html.a(styles.button(), [attribute.href(link)], [
            html.text("showcase"),
          ]),
        ]
      }
      |> option.unwrap([])
    ],
  )
}

pub fn view() -> List(Element(msg)) {
  [
    html.h1_([], [html.text("Projects")]),
    html.p_([], [
      html.text(
        "Some personal projects I have worked on, with the goal
      of trying a different language and skill each time.",
      ),
    ]),
    html.div(
      css.class([
        css.display("flex"),
        css.flex_wrap("wrap"),
        css.flex_direction("row"),
        css.justify_content("center"),
        css.align_content("space-between"),
        css.gap(length.px(20)),
      ]),
      [],
      [
        project_card(
          "Raytracing in Zig",
          "https://github.com/oslewei/zig-rtweekend",
          Some("/raytracing"),
        ),
        project_card(
          "Deep Learning in C",
          "https://github.com/oslewei/c-machine-learning",
          None,
        ),
        project_card(
          "This Portfolio",
          "https://github.com/oslewei/portfolio",
          None,
        ),
      ],
    ),
  ]
}
