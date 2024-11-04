import lustre/attribute
import lustre/element/html
import sketch/styles/components/video/video_styles as styles

pub opaque type VideoProps {
  VideoProps(id: String, video_url: String)
}

pub fn new(id: String, video_url: String) {
  VideoProps(id, video_url)
}

pub type VideoCommands {
  Play
  Pause
  Mute
  UnMute
  Stop
}

pub fn view(video_props: VideoProps) {
  html.iframe([
    attribute.class(styles.iframe_video),
    attribute.id(video_props.id),
    attribute.src(video_props.video_url),
    attribute.attribute("frameborder", "0"),
    attribute.attribute("allow", "autoplay; encrypted-media"),
    attribute.attribute("allowfullscreen", "true"),
  ])
}

@external(javascript, "../../cfb_watcher.ffi.mjs", "sendCommandToVideo")
fn send_command_to_video(id: String, command: String) -> a

pub fn video_command(id: String, command: VideoCommands) {
  send_command_to_video(id, video_commands_to_string(command))
}

pub fn video_commands_to_string(command: VideoCommands) -> String {
  case command {
    Play -> "playVideo"
    Pause -> "pauseVideo"
    Mute -> "mute"
    UnMute -> "unMute"
    Stop -> "stopVideo"
  }
}

pub fn play(id: String) {
  video_command(id, Play)
}

pub fn pause(id: String) {
  video_command(id, Pause)
}

pub fn mute(id: String) {
  video_command(id, Mute)
}

pub fn unmute(id: String) {
  video_command(id, UnMute)
}
