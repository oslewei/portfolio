import gleam/list
import gleam/option.{type Option, None, Some}
import lustre/attribute
import lustre/element.{type Element}
import sketch/css
import sketch/css/length
import sketch/lustre/element/html
import styles

fn tags_container(tags: List(String)) -> Element(a) {
  html.div(
    css.class([
      css.display("flex"),
      css.column_gap(length.px(10)),
    ]),
    [],
    tags
      |> list.map(tag_element),
  )
}

fn tag_element(tag: String) -> Element(a) {
  html.div(
    css.class([
      css.background_color(styles.var_ac_color),
      css.box_shadow("2px 2px gray"),
    ]),
    [],
    [html.text(tag)],
  )
}

fn optional_link(showcase_link: Option(String)) -> List(Element(a)) {
  case showcase_link {
    Some(link) -> [
      html.a(styles.button(), [attribute.href(link)], [
        html.text("showcase"),
      ]),
    ]
    None -> []
  }
}

fn project_card(
  title: String,
  description: String,
  repository repository: String,
  tags tags: List(String),
  showcase_link showcase_link: Option(String),
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
      html.p_([], [html.text(description)]),
      tags_container(tags),
      html.a(styles.button(), [attribute.href(repository)], [
        html.text("repository"),
      ]),
      ..optional_link(showcase_link)
    ],
  )
}

pub fn view() -> Element(msg) {
  element.fragment([
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
          "Pathtracer in Zig",
          "Pathtracer written in Zig, following the Raytracing in One Weekend book series",
          "https://github.com/oslewei/zig-rtweekend",
          Some("/raytracing"),
          tags: ["Zig"],
        ),
        project_card(
          "Deep Learning in C",
          "Deep Leanring library written from scratch in C, with no mandatory external dependencies",
          "https://github.com/oslewei/c-machine-learning",
          None,
          tags: ["Machine Learning", "C"],
        ),
        project_card(
          "This Portfolio",
          "This portfolio, written in Gleam with Lustre",
          "https://github.com/oslewei/portfolio",
          None,
          tags: ["Gleam", "Lustre"],
        ),
      ],
    ),
  ])
}
