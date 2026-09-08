import lustre/attribute
import lustre/element.{type Element}
import shared
import sketch/css
import sketch/css/length
import sketch/lustre/element/html
import styles

fn project_card(
  title: String,
  showcase_link: String,
  repository: String,
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

      html.a(styles.button(), [attribute.href(showcase_link)], [
        html.text("showcase"),
      ]),
      html.a(styles.button(), [attribute.href(repository)], [
        html.text("repository"),
      ]),
    ],
  )
}

pub fn view() -> List(Element(msg)) {
  [
    html.h1_([], [html.text("Projects")]),
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
          "/raytracing",
          "https://github.com/oslewei/zig-rtweekend",
        ),
        project_card(
          "Deep Learning in C",
          "/ai",
          "https://github.com/oslewei/c-machine-learning",
        ),
        project_card(
          "This Portfolio",
          "/",
          "https://github.com/oslewei/portfolio",
        ),
      ],
    ),
  ]
}
