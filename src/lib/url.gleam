import gleam/list
import gleam/option
import gleam/regex
import gleam/result

pub fn youtube_url_valid(url: String) -> Bool {
  "https://www.youtube.com/watch\\?v=[a-zA-Z0-9_-]+"
  |> regex.from_string
  |> result.nil_error
  |> result.map(regex.check(_, url))
  |> result.unwrap(False)
}

pub fn extract_youtube_id(youtube_url: String) -> String {
  "https://www.youtube.com/watch\\?v=([a-zA-Z0-9_-]+)"
  |> regex.from_string
  |> result.nil_error
  |> result.map(regex.scan(_, youtube_url))
  |> result.try(list.first)
  |> result.map(fn(m: regex.Match) { m.submatches })
  |> result.unwrap([])
  |> list.first
  |> result.unwrap(option.None)
  |> option.unwrap("")
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
