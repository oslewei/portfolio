import styles
import sketch/css
import icons/icon_wrapper
import icons/icons
import lustre/attribute.{type Attribute}
import lustre/element.{type Element}
import sketch/lustre/element/html

fn icon(link: String, icon: fn(List(Attribute(msg))) -> Element(msg)) -> Element(msg) {
  html.a_([attribute.href(link)], [icon_wrapper.icon(
    css.class([
      css.color(styles.var_fg_color)
    ]),
    [],
    icon
  )])
}

pub fn view() -> List(Element(a)) {
  [
    html.h1_([], [html.text("Oscar Weimann")]),
    html.h2_([], [html.text("Welcome to my tech portfolio!")]),
    html.div_([], [
      icon("https://github.com/oslewei", icons.github),
      icon("https://tangled.org/os1to.tngl.sh", icons.tangled),
    ]),
  ]
}
