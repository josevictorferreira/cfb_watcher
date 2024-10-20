import components/lucide_icons
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
    html.button([attribute.class("overlay-button"), ..props.focus_attributes], [
      lucide_icons.focus([]),
    ]),
    html.button([attribute.class("overlay-button"), ..props.remove_attributes], [
      lucide_icons.trash_2([]),
    ]),
  ])
}
