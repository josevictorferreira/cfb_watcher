import sketch as s
import sketch.{type Class}
import sketch/size.{percent, px}

fn curtain_button() -> Class {
  s.class([
    s.position("absolute"),
    s.top(px(20)),
    s.right(px(20)),
    s.width(px(40)),
    s.height(px(40)),
    s.background_color("#333333"),
    s.border_radius(px(5)),
    s.overflow("hidden"),
    s.cursor("pointer"),
    s.transition("width 0.3s ease, height 0.3s ease"),
    s.hover([s.width(px(60)), s.height(px(60))]),
    s.z_index(10),
  ])
}

fn curtain_content() -> Class {
  s.class([
    s.width(percent(100)),
    s.height(percent(100)),
    s.display("flex"),
    s.justify_content("center"),
    s.align_items("center"),
  ])
}

fn add_icon() -> Class {
  s.class([
    s.font_size(px(20)),
    s.color("#F5F5F7"),
    s.transition("transform 0.3s ease"),
    s.hover([s.transform("scale(1.2)")]),
  ])
}
