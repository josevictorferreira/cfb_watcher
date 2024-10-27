import components/icons/lucide
import lustre/attribute
import lustre/element
import lustre/element/html
import sketch/styles/components/curtain_button/curtain_button_styles as styles

pub opaque type CurtainButtonProps(msg) {
  CurtainButtonProps(msg: msg, attributes: List(attribute.Attribute(msg)))
}

pub fn new(msg, attributes) -> CurtainButtonProps(msg) {
  CurtainButtonProps(msg, attributes)
}

pub fn view(props: CurtainButtonProps(msg)) -> element.Element(msg) {
  html.div([attribute.class(styles.curtain_button)], [
    html.div([attribute.class(styles.curtain_content), ..props.attributes], [
      html.span([attribute.class(styles.add_icon)], [lucide.circle_plus([])]),
    ]),
  ])
}
