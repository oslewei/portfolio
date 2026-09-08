import lustre/attribute
import lustre/element.{type Element}
import sketch/css
import sketch/css/length
import sketch/lustre/element/html
import styles

pub fn view() -> List(Element(message)) {
  [
    html.h1_([], [html.text("About")]),
    html.p_([], [
      html.text(
        "Hello my name is Oscar, a passionate programmer currently focusing"
        <> " on cybersecurity and backend development",
      ),
    ]),
    html.a(
      styles.button(),
      [
        attribute.download("OscarWeimannCV.pdf"),
        attribute.href("OscarWeimannCV.pdf"),
      ],
      [html.text("My CV")],
    ),
  ]
}
