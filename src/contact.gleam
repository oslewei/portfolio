import gleam/javascript/promise.{type Promise}
import lustre/element.{type Element}
import lustre/event
import shared.{type Msg, UserPressedEmail}
import sketch/css
import sketch/lustre/element/html

// NOT USED
@external(javascript, "./browser_ffi.mjs", "readText")
pub fn read_text() -> Promise(Result(String, String))

@external(javascript, "./browser_ffi.mjs", "writeText")
pub fn write_text(clip_text: String) -> Promise(Result(Nil, String))

pub fn view() -> List(Element(Msg)) {
  [
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
  ]
}
