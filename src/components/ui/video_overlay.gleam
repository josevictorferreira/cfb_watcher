import lustre/attribute
import lustre/element
import lustre/element/html

pub type VideoOverlayProps(msg) {
  VideoOverlayProps(
    msg: msg,
    focus_attributes: List(attribute.Attribute(msg)),
    remove_attributes: List(attribute.Attribute(msg)),
  )
}

pub fn new(msg, focus_attributes, remove_attributes) -> VideoOverlayProps(msg) {
  VideoOverlayProps(msg, focus_attributes, remove_attributes)
}

pub fn view(props: VideoOverlayProps(msg)) -> element.Element(msg) {
  html.div([attribute.class("overlay")], [
    html.button([attribute.value("play"), attribute.class("overlay-button")], [
      html.text("Play"),
    ]),
    html.button([attribute.class("overlay-button")], [html.text("Pause")]),
    html.button([attribute.class("overlay-button")], [html.text("Mute")]),
    html.button([attribute.class("overlay-button"), ..props.focus_attributes], [
      html.text("Focus"),
    ]),
    html.button(
      [
        attribute.value("removed"),
        attribute.class("overlay-button"),
        ..props.remove_attributes
      ],
      [html.text("Remove")],
    ),
  ])
}
