import gleam/regex

pub fn youtube_url_valid(url: String) -> Bool {
  let assert Ok(re) =
    regex.from_string("https://www.youtube.com/watch\\?v=[a-zA-Z0-9_-]+")
  regex.check(re, url)
}

pub fn extract_youtube_id(youtube_url: String) -> Result(String, String) {
  let assert Ok(re) =
    regex.from_string("https://www.youtube.com/watch\\?v=([a-zA-Z0-9_-]+)")
  case regex.scan(re, youtube_url) {
    [match, ..] -> Ok(match.content)
    [] -> Error("No matches found")
  }
}

pub fn format_youtube_video_url(
  video_id video_id: String,
  muted muted: Bool,
) -> String {
  let mute = case muted {
    True -> "1"
    False -> "0"
  }

  "https://www.youtube.com/embed/"
  <> video_id
  <> "?enablejsapi=1"
  <> "&cc_load_policy=3"
  <> "&autoplay=1"
  <> "&mute="
  <> mute
}
