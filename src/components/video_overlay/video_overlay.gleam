import components/icons/lucide
import lustre/attribute
import lustre/element
import lustre/element/html
import sketch/styles/components/video_overlay/video_overlay_styles as styles

pub opaque type VideoOverlayProps(msg) {
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
  html.div([attribute.class(styles.overlay)], [
    html.button(
      [attribute.class(styles.overlay_button), ..props.focus_attributes],
      [lucide.focus([])],
    ),
    html.button(
      [attribute.class(styles.overlay_button), ..props.remove_attributes],
      [lucide.trash_2([])],
    ),
  ])
}
