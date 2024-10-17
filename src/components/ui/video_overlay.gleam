import lustre/attribute
import lustre/element
import lustre/element/html
import lustre/event

pub type VideoOverlayProps(msg) {
  VideoOverlayProps(msg: msg)
}

pub fn new(msg) -> VideoOverlayProps(msg) {
  VideoOverlayProps(msg)
}

pub fn view(props: VideoOverlayProps(msg)) -> element.Element(msg) {
  html.div([attribute.class("overlay")], [
    html.button(
      [
        attribute.value("play"),
        attribute.class("overlay-button"),
        event.on_click(props.msg),
      ],
      [html.text("Play")],
    ),
    html.button([attribute.class("overlay-button")], [html.text("Pause")]),
    html.button([attribute.class("overlay-button")], [html.text("Mute")]),
    html.button(
      [
        attribute.value("removed"),
        attribute.class("overlay-button"),
        event.on_click(props.msg),
      ],
      [html.text("Remove")],
    ),
  ])
}
