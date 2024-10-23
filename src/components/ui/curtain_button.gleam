import components/lucide_icons
import lustre/attribute
import sketch as s
import sketch/lustre/element
import sketch/lustre/element/html
import sketch/size.{percent, px}

pub opaque type CurtainButtonProps(msg) {
  CurtainButtonProps(msg: msg, attributes: List(attribute.Attribute(msg)))
}

pub fn new(msg, attributes) -> CurtainButtonProps(msg) {
  CurtainButtonProps(msg, attributes)
}

pub fn view(props: CurtainButtonProps(msg)) -> element.Element(msg) {
  html.div(curtain_button_class(), [], [
    html.div(curtain_content_class(), props.attributes, [
      html.span(add_icon_class(), [], [lucide_icons.circle_plus([])]),
    ]),
  ])
}

fn curtain_button_class() {
  s.class([
    s.position("absolute"),
    s.top(px(20)),
    s.right(px(20)),
    s.width(px(40)),
    s.height(px(40)),
    s.background_color("#333"),
    s.border_radius(px(5)),
    s.overflow("hidden"),
    s.cursor("pointer"),
    s.transition("width 0.3s ease, height 0.3s ease"),
  ])
}

fn curtain_content_class() {
  s.class([
    s.width(percent(100)),
    s.height(percent(100)),
    s.display("flex"),
    s.justify_content("center"),
    s.align_items("center"),
  ])
}

fn add_icon_class() {
  s.class([
    s.font_size(px(20)),
    s.color("white"),
    s.transition("transform 0.3s ease"),
  ])
}
