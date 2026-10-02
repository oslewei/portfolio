import sketch/css/length
import icon/icon
import icon/icon_wrapper
import lustre/attribute.{type Attribute}
import lustre/element.{type Element}
import sketch/css
import sketch/lustre/element/html
import styles

fn icon(
  link: String,
  icon: fn(List(Attribute(msg))) -> Element(msg),
) -> Element(msg) {
  html.a_([attribute.href(link)], [
    icon_wrapper.icon(css.class([css.color(styles.var_fg_color)]), [], icon),
  ])
}

pub fn view() -> Element(a) {
  html.div(css.class([
    css.height(length.vh(100))
  ]), [], [
    html.h1_([], [html.text("Oscar Weimann")]),
    html.h2_([], [html.text("Welcome to my tech portfolio!")]),
    html.div_([], [
      icon("https://github.com/oslewei", icon.github),
      icon("https://tangled.org/os1to.tngl.sh", icon.tangled),
    ]),
  ])
}
