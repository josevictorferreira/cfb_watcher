import components/ui/video
import components/ui/video_overlay
import gleam/list
import lustre
import lustre/attribute
import lustre/element
import lustre/element/html
import lustre/event

pub fn main() {
  let app = lustre.simple(init, update, view)
  let assert Ok(_) = lustre.start(app, "#app", Nil)

  Nil
}

fn init(_flags) -> Model {
  Model(games: [
    CfbGame(video_id: "mjikSatnIOY"),
    CfbGame(video_id: "LmAaCgp9YyE"),
    CfbGame(video_id: "sPtP830hITs"),
    CfbGame(video_id: "9FgQ6qvMePk"),
    CfbGame(video_id: "PQ2r0sV1hUs"),
    CfbGame(video_id: "RBZ8FnSXfLs"),
    CfbGame(video_id: "7VjKEkqry6g"),
  ])
}

pub type CfbGame {
  CfbGame(video_id: String)
}

pub type Model {
  Model(games: List(CfbGame))
}

pub type Msg {
  VideoFocused(CfbGame)
  VideoRemoved(CfbGame)
}

pub fn update(model: Model, msg: Msg) -> Model {
  case msg {
    VideoRemoved(cfb_game) ->
      Model(games: list.filter(model.games, fn(game) { game != cfb_game }))
    VideoFocused(cfb_game) -> {
      let assert Ok(first_game) = list.first(model.games)
      case first_game == cfb_game {
        True -> {
          video.unmute(first_game.video_id)
          Model(games: model.games)
        }
        False -> {
          video.mute(first_game.video_id)
          video.unmute(cfb_game.video_id)
          Model(
            games: list.concat([
              [CfbGame(video_id: cfb_game.video_id)],
              list.filter(model.games, fn(game) { game != cfb_game }),
            ]),
          )
        }
      }
    }
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
    [] -> CfbGame(video_id: "")
  }
  case important_game.video_id == "" {
    True -> html.div([], [])
    False ->
      html.div(
        [attribute.class("video-container"), attribute.class("video-large")],
        [video_view(important_game, False), video_overlay_view(important_game)],
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
      [video_view(game, True), video_overlay_view(game)],
    )
  })
}

fn small_videos(games: List(CfbGame)) -> element.Element(Msg) {
  let small_important_game = list.drop(games, 3)

  html.div(
    [attribute.class("small-videos")],
    list.map(small_important_game, fn(game: CfbGame) {
      html.div([attribute.class("video-container")], [
        video_view(game, True),
        video_overlay_view(game),
      ])
    }),
  )
}

fn video_view(game: CfbGame, muted: Bool) -> element.Element(Msg) {
  video.new(game.video_id, youtube_video_url(game, muted))
  |> video.view
}

fn video_overlay_view(game: CfbGame) -> element.Element(Msg) {
  video_overlay.new(VideoFocused(game), [event.on_click(VideoFocused(game))], [
    event.on_click(VideoRemoved(game)),
  ])
  |> video_overlay.view
}

fn youtube_video_url(game: CfbGame, muted: Bool) -> String {
  let mute = case muted {
    True -> "1"
    False -> "0"
  }

  "https://www.youtube.com/embed/"
  <> game.video_id
  <> "?enablejsapi=1"
  <> "&autoplay=1"
  <> "&mute="
  <> mute
}
