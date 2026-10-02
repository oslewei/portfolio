import lustre/element.{type Element}
import lustre/event
import message.{type Msg, UserPressedEmail}
import sketch/css
import sketch/lustre/element/html

pub fn view() -> Element(Msg) {
  element.fragment([
    html.h1_([], [html.text("Contact")]),
    html.p_([], [
      html.text("Email: "),
      html.span(
        css.class([css.cursor("pointer")]),
        [event.on_click(UserPressedEmail)],
        [
          html.text("oslewei@proton.me"),
        ],
      ),
    ]),
  ])
}
