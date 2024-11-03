import sketch as s
import sketch.{type Class}
import sketch/size.{percent, px, vh}

fn dialog_overlay() -> Class {
  s.class([
    s.position("fixed"),
    s.top(px(0)),
    s.left(px(0)),
    s.width(percent(100)),
    s.height(percent(100)),
    s.background_color("rgba(0, 0, 0, 0.5)"),
    s.display("none"),
    s.justify_content("center"),
    s.align_items("flex-start"),
    s.padding_top(vh(15)),
    s.z_index(200),
  ])
}

fn command_dialog() -> Class {
  s.class([
    s.background("white"),
    s.padding(px(20)),
    s.border_radius(px(8)),
    s.box_shadow("0 2px 10px rgba(0, 0, 0, 0.1)"),
    s.width(percent(80)),
    s.max_width(px(600)),
  ])
}

fn command_input() -> Class {
  s.class([
    s.width(percent(100)),
    s.padding(px(10)),
    s.border("1px solid #ccc"),
    s.border_radius(px(4)),
    s.font_size(px(16)),
    s.margin_bottom(px(10)),
  ])
}

fn command_dialog_button() -> Class {
  s.class([
    s.background_color("#333"),
    s.color("white"),
    s.border("none"),
    s.padding(px(8)),
    s.cursor("pointer"),
    s.font_size(px(16)),
    s.border_radius(px(4)),
    s.margin_left(px(5)),
  ])
}

fn submit_button() -> Class {
  s.class([s.background_color("#333"), s.color("white")])
}

fn cancel_button() -> Class {
  s.class([s.background_color("#ccc"), s.color("#333")])
}

fn show() -> Class {
  s.class([s.display("flex !important")])
}
