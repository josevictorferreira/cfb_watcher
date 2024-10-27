import sketch as s
import sketch.{type Class}
import sketch/size.{percent, px}

fn iframe_video() -> Class {
  s.class([
    s.position("absolute"),
    s.top(px(0)),
    s.left(px(0)),
    s.width(percent(100)),
    s.height(percent(100)),
  ])
}
