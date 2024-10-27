import sketch as s
import sketch.{type Class}
import sketch/media
import sketch/size.{percent, px, vh}

fn container() -> Class {
  s.class([s.position("relative"), s.width(percent(100)), s.height(vh(100))])
}

fn video_grid() -> Class {
  s.class([
    s.display("grid"),
    s.grid_template_columns("70% 30%"),
    s.grid_template_rows("repeat(3, 1fr)"),
    s.gap(px(10)),
    s.height(vh(100)),
    s.padding(px(10)),
    s.box_sizing("border-box"),
    s.media(media.max_width(px(768)), [
      s.grid_template_columns("1fr"),
      s.grid_template_rows("auto"),
    ]),
  ])
}

fn video_container() -> Class {
  s.class([
    s.position("relative"),
    s.width(percent(100)),
    s.height(percent(100)),
  ])
}

fn video_large() -> Class {
  s.class([
    s.grid_column("1"),
    s.grid_row("1 / span 3"),
    s.media(media.max_width(px(768)), [s.grid_column("1"), s.grid_row("span 2")]),
  ])
}

fn video_medium() -> Class {
  s.class([
    s.grid_column("2"),
    s.grid_row("span 1"),
    s.media(media.max_width(px(768)), [s.grid_column("1"), s.grid_row("span 1")]),
  ])
}

fn small_videos() -> Class {
  s.class([
    s.grid_column("2"),
    s.grid_row("3"),
    s.display("grid"),
    s.grid_template_columns("repeat(2, 1fr)"),
    s.gap(px(5)),
    s.media(media.max_width(px(768)), [s.grid_column("1"), s.grid_row("span 1")]),
  ])
}
