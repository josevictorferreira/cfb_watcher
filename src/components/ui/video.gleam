import lustre/attribute
import lustre/element/html

pub type VideoProps {
  VideoProps(video_url: String)
}

pub fn new(video_url: String) {
  VideoProps(video_url)
}

pub fn view(video_props: VideoProps) {
  html.iframe([
    attribute.src(video_props.video_url),
    attribute.attribute("frameborder", "0"),
    attribute.attribute("allowfullscreen", "true"),
    iframe_styles(),
  ])
}

fn iframe_styles() {
  attribute.style([
    #("position", "absolute"),
    #("top", "0"),
    #("left", "0"),
    #("width", "100%"),
    #("height", "100%"),
  ])
}
