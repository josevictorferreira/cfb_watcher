import sketch as s
import sketch.{type Class}
import sketch/size.{percent, px}

fn overlay() -> Class {
  s.class([
    s.position("absolute"),
    s.top(px(0)),
    s.left(px(0)),
    s.width(percent(100)),
    s.height(percent(100)),
    s.background_color("rgba(0, 0, 0, 0.7)"),
    s.display("flex"),
    s.justify_content("center"),
    s.align_items("center"),
    s.opacity(0.0),
    s.transition("opacity 0.3s ease"),
    s.hover([s.opacity(1.0)]),
  ])
}

fn overlay_button() -> Class {
  s.class([
    s.background_color("#ffffff"),
    s.color("#000000"),
    s.border("none"),
    s.padding(px(10)),
    s.margin(px(5)),
    s.cursor("pointer"),
    s.font_size(px(16)),
    s.border_radius(px(5)),
  ])
}
