import lustre/attribute.{type Attribute, attribute}
import lustre/element/svg

pub fn sun(attributes: List(Attribute(a))) {
  svg.svg(
    [
      attribute("stroke-linejoin", "round"),
      attribute("stroke-linecap", "round"),
      attribute("stroke-width", "2"),
      attribute("stroke", "currentColor"),
      attribute("fill", "none"),
      attribute("viewBox", "0 0 24 24"),
      attribute("height", "24"),
      attribute("width", "24"),
      ..attributes
    ],
    [
      svg.circle([
        attribute("r", "4"),
        attribute("cy", "12"),
        attribute("cx", "12"),
      ]),
      svg.path([attribute("d", "M12 2v2")]),
      svg.path([attribute("d", "M12 20v2")]),
      svg.path([attribute("d", "m4.93 4.93 1.41 1.41")]),
      svg.path([attribute("d", "m17.66 17.66 1.41 1.41")]),
      svg.path([attribute("d", "M2 12h2")]),
      svg.path([attribute("d", "M20 12h2")]),
      svg.path([attribute("d", "m6.34 17.66-1.41 1.41")]),
      svg.path([attribute("d", "m19.07 4.93-1.41 1.41")]),
    ],
  )
}

pub fn moon(attributes: List(Attribute(a))) {
  svg.svg(
    [
      attribute("stroke-linejoin", "round"),
      attribute("stroke-linecap", "round"),
      attribute("stroke-width", "2"),
      attribute("stroke", "currentColor"),
      attribute("fill", "none"),
      attribute("viewBox", "0 0 24 24"),
      attribute("height", "24"),
      attribute("width", "24"),
      ..attributes
    ],
    [
      svg.path([
        attribute(
          "d",
          "M20.985 12.486a9 9 0 1 1-9.473-9.472c.405-.022.617.46.402.803a6 6 0 0 0 8.268 8.268c.344-.215.825-.004.803.401",
        ),
      ]),
    ],
  )
}

pub fn hamburger(attributes: List(Attribute(a))) {
  svg.svg(
    [
      attribute("stroke-linejoin", "round"),
      attribute("stroke-linecap", "round"),
      attribute("stroke-width", "2"),
      attribute("stroke", "currentColor"),
      attribute("fill", "none"),
      attribute("viewBox", "0 0 24 24"),
      attribute("height", "24"),
      attribute("width", "24"),
      ..attributes
    ],
    [
      svg.path([attribute("d", "M12 16H4a2 2 0 1 1 0-4h16a2 2 0 1 1 0 4h-4.25")]),
      svg.path([
        attribute("d", "M5 12a2 2 0 0 1-2-2 9 7 0 0 1 18 0 2 2 0 0 1-2 2"),
      ]),
      svg.path([
        attribute(
          "d",
          "M5 16a2 2 0 0 0-2 2 3 3 0 0 0 3 3h12a3 3 0 0 0 3-3 2 2 0 0 0-2-2q0 0 0 0",
        ),
      ]),
      svg.path([attribute("d", "m6.67 12 6.13 4.6a2 2 0 0 0 2.8-.4l3.15-4.2")]),
    ],
  )
}
