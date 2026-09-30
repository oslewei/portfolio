import sketch/css/length
import sketch/lustre/element.{type Element}
import lustre/attribute.{type Attribute}
import sketch/css

pub fn icon(class: css.Class, attributes: List(Attribute(msg)), icon: fn(List(Attribute(msg))) -> Element(msg)) -> Element(msg) {
  icon([attribute.class(element.class_name(
    css.class(
      [
        css.width(length.px(20)),
        css.height(length.px(20)),
        css.compose(class)
      ]
    )
  )), ..attributes])
}