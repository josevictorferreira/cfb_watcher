import lustre/attribute
import lustre/element
import lustre/element/html

pub type VideoOverlayProps(msg) {
  VideoOverlayProps(
    msg: msg,
    play_attributes: List(attribute.Attribute(msg)),
    pause_attributes: List(attribute.Attribute(msg)),
    mute_attributes: List(attribute.Attribute(msg)),
    unmute_attributes: List(attribute.Attribute(msg)),
    focus_attributes: List(attribute.Attribute(msg)),
    remove_attributes: List(attribute.Attribute(msg)),
  )
}

pub fn new(
  msg,
  play_attributes,
  pause_attributes,
  mute_attributes,
  unmute_attributes,
  focus_attributes,
  remove_attributes,
) -> VideoOverlayProps(msg) {
  VideoOverlayProps(
    msg,
    play_attributes,
    pause_attributes,
    mute_attributes,
    unmute_attributes,
    focus_attributes,
    remove_attributes,
  )
}

pub fn view(props: VideoOverlayProps(msg)) -> element.Element(msg) {
  html.div([attribute.class("overlay")], [
    html.button([attribute.class("overlay-button"), ..props.play_attributes], [
      html.text("Play"),
    ]),
    html.button([attribute.class("overlay-button"), ..props.pause_attributes], [
      html.text("Pause"),
    ]),
    html.button([attribute.class("overlay-button"), ..props.mute_attributes], [
      html.text("Mute"),
    ]),
    html.button([attribute.class("overlay-button"), ..props.unmute_attributes], [
      html.text("Unmute"),
    ]),
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
