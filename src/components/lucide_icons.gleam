import lustre/attribute.{type Attribute, attribute}
import lustre/element/svg

pub fn focus(attributes: List(Attribute(a))) {
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
        attribute("r", "3"),
        attribute("cy", "12"),
        attribute("cx", "12"),
      ]),
      svg.path([attribute("d", "M3 7V5a2 2 0 0 1 2-2h2")]),
      svg.path([attribute("d", "M17 3h2a2 2 0 0 1 2 2v2")]),
      svg.path([attribute("d", "M21 17v2a2 2 0 0 1-2 2h-2")]),
      svg.path([attribute("d", "M7 21H5a2 2 0 0 1-2-2v-2")]),
    ],
  )
}

pub fn trash_2(attributes: List(Attribute(a))) {
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
      svg.path([attribute("d", "M3 6h18")]),
      svg.path([attribute("d", "M19 6v14c0 1-1 2-2 2H7c-1 0-2-1-2-2V6")]),
      svg.path([attribute("d", "M8 6V4c0-1 1-2 2-2h4c1 0 2 1 2 2v2")]),
      svg.line([
        attribute("y2", "17"),
        attribute("y1", "11"),
        attribute("x2", "10"),
        attribute("x1", "10"),
      ]),
      svg.line([
        attribute("y2", "17"),
        attribute("y1", "11"),
        attribute("x2", "14"),
        attribute("x1", "14"),
      ]),
    ],
  )
}
