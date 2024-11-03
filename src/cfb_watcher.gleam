import components/command_dialog/command_dialog
import components/curtain_button/curtain_button
import components/video/video
import components/video_overlay/video_overlay
import gleam/list
import lustre
import lustre/attribute
import lustre/element
import lustre/element/html
import lustre/event
import sketch/styles/cfb_watcher_styles as styles

pub fn main() {
  let app = lustre.simple(init, update, view)
  let assert Ok(_) = lustre.start(app, "#app", Nil)

  Nil
}

fn init(_flags) -> Model {
  Model(
    games: [
      CfbGame(video_id: "mjikSatnIOY"),
      CfbGame(video_id: "LmAaCgp9YyE"),
      CfbGame(video_id: "sPtP830hITs"),
      CfbGame(video_id: "9FgQ6qvMePk"),
      CfbGame(video_id: "PQ2r0sV1hUs"),
      CfbGame(video_id: "RBZ8FnSXfLs"),
      CfbGame(video_id: "7VjKEkqry6g"),
    ],
    command_dialog_visible: False,
    command_dialog_value: "",
  )
}

pub opaque type CfbGame {
  CfbGame(video_id: String)
}

pub opaque type Model {
  Model(
    games: List(CfbGame),
    command_dialog_visible: Bool,
    command_dialog_value: String,
  )
}

pub opaque type Msg {
  VideoFocused(CfbGame)
  VideoRemoved(CfbGame)
  UserOpenCommandDialog
  UserClosedCommandDialog
  UserInputtedCommandDialog(String)
  UserSubmitCommandDialog
}

pub fn update(model: Model, msg: Msg) -> Model {
  case msg {
    UserInputtedCommandDialog(value) -> {
      Model(..model, command_dialog_value: value)
    }
    UserSubmitCommandDialog -> {
      Model(..model, command_dialog_visible: False)
    }
    UserClosedCommandDialog -> {
      Model(..model, command_dialog_value: "", command_dialog_visible: False)
    }
    UserOpenCommandDialog -> {
      Model(..model, command_dialog_value: "", command_dialog_visible: True)
    }
    VideoRemoved(cfb_game) ->
      Model(
        ..model,
        games: list.filter(model.games, fn(game) { game != cfb_game }),
      )
    VideoFocused(cfb_game) -> {
      let assert Ok(first_game) = list.first(model.games)
      case first_game == cfb_game {
        True -> {
          video.unmute(first_game.video_id)
          Model(..model, games: model.games)
        }
        False -> {
          video.mute(first_game.video_id)
          video.unmute(cfb_game.video_id)
          Model(
            ..model,
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
  html.div([attribute.class(styles.container)], [
    curtain_button(),
    command_dialog(model.command_dialog_visible, model.command_dialog_value),
    video_panel(model.games),
  ])
}

fn command_dialog(visible: Bool, input_value: String) {
  command_dialog.new(
    UserClosedCommandDialog,
    visible,
    input_value,
    [event.on_click(UserSubmitCommandDialog)],
    [event.on_click(UserClosedCommandDialog)],
    [event.on_input(fn(value: String) { UserInputtedCommandDialog(value) })],
  )
  |> command_dialog.view
}

fn video_panel(games: List(CfbGame)) {
  html.div(
    [attribute.class(styles.video_grid)],
    list.flatten([
      [large_videos(games)],
      medium_videos(games),
      [small_videos(games)],
    ]),
  )
}

fn curtain_button() -> element.Element(Msg) {
  curtain_button.new(UserOpenCommandDialog, [
    event.on_click(UserOpenCommandDialog),
  ])
  |> curtain_button.view
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
        [
          attribute.class(styles.video_container),
          attribute.class(styles.video_large),
        ],
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
      [
        attribute.class(styles.video_container),
        attribute.class(styles.video_medium),
      ],
      [video_view(game, True), video_overlay_view(game)],
    )
  })
}

fn small_videos(games: List(CfbGame)) -> element.Element(Msg) {
  let small_important_game = list.drop(games, 3)

  html.div(
    [attribute.class(styles.small_videos)],
    list.map(small_important_game, fn(game: CfbGame) {
      html.div([attribute.class(styles.video_container)], [
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
