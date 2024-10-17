import components/ui/video
import components/ui/video_overlay
import gleam/list
import lustre
import lustre/attribute
import lustre/element
import lustre/element/html

pub fn main() {
  let app = lustre.simple(init, update, view)
  let assert Ok(_) = lustre.start(app, "#app", Nil)

  Nil
}

fn init(_flags) -> Model {
  Model(games: [
    CfbGame(video_id: "mjikSatnIOY", autoplay: True, muted: True),
    CfbGame(video_id: "LmAaCgp9YyE", autoplay: True, muted: True),
    CfbGame(video_id: "sPtP830hITs", autoplay: True, muted: True),
    CfbGame(video_id: "9FgQ6qvMePk", autoplay: True, muted: True),
    CfbGame(video_id: "PQ2r0sV1hUs", autoplay: True, muted: True),
    CfbGame(video_id: "RBZ8FnSXfLs", autoplay: True, muted: True),
    CfbGame(video_id: "uZDPXFQYz0Q", autoplay: True, muted: True),
    CfbGame(video_id: "OlUMDZchivQ", autoplay: True, muted: True),
  ])
}

pub type CfbGame {
  CfbGame(video_id: String, autoplay: Bool, muted: Bool)
}

pub type Model {
  Model(games: List(CfbGame))
}

pub type Msg {
  CfbGameRemoved(CfbGame)
}

pub fn update(model: Model, msg: Msg) -> Model {
  case msg {
    CfbGameRemoved(cfb_game) ->
      Model(games: list.filter(model.games, fn(game) { game != cfb_game }))
  }
}

pub fn view(model: Model) -> element.Element(Msg) {
  video_panel(model.games)
}

pub fn video_panel(games: List(CfbGame)) {
  html.div(
    [attribute.class("video-grid")],
    list.flatten([
      [large_videos(games)],
      medium_videos(games),
      [small_videos(games)],
    ]),
  )
}

fn large_videos(games: List(CfbGame)) -> element.Element(Msg) {
  let important_game: CfbGame = case list.take(games, 1) {
    [game, ..] -> game
    [] -> CfbGame(video_id: "", autoplay: False, muted: False)
  }
  case important_game.video_id == "" {
    True -> html.div([], [])
    False ->
      html.div(
        [attribute.class("video-container"), attribute.class("video-large")],
        [video_view(important_game), video_overlay_view(important_game)],
      )
  }
}

fn medium_videos(games: List(CfbGame)) -> List(element.Element(Msg)) {
  let medium_important_games = case list.drop(games, 1) {
    [game2, game3, ..] -> [game2, game3]
    [game2, ..] -> [game2]
    [] -> []
  }

  list.map(medium_important_games, fn(game: CfbGame) -> element.Element(Msg) {
    html.div(
      [attribute.class("video-container"), attribute.class("video-medium")],
      [video_view(game), video_overlay_view(game)],
    )
  })
}

fn small_videos(games: List(CfbGame)) -> element.Element(Msg) {
  let small_important_game = list.drop(games, 3)

  html.div(
    [attribute.class("small-videos")],
    list.map(small_important_game, fn(game: CfbGame) {
      html.div([attribute.class("video-container")], [
        video_view(game),
        video_overlay_view(game),
      ])
    }),
  )
}

fn video_view(game: CfbGame) -> element.Element(Msg) {
  youtube_video_url(game)
  |> video.new
  |> video.view
}

fn video_overlay_view(game: CfbGame) -> element.Element(Msg) {
  CfbGameRemoved(game)
  |> video_overlay.new
  |> video_overlay.view
}

fn youtube_video_url(game: CfbGame) -> String {
  let autoplay = case game.autoplay {
    True -> "1"
    False -> "0"
  }
  let mute = case game.muted {
    True -> "1"
    False -> "0"
  }

  "https://www.youtube.com/embed/"
  <> game.video_id
  <> "?autoplay="
  <> autoplay
  <> "&mute="
  <> mute
}
