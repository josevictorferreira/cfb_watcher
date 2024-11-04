import components/command_dialog/command_dialog
import components/curtain_button/curtain_button
import components/video/video
import components/video_overlay/video_overlay
import gleam/list
import lustre
import lustre/attribute
import lustre/effect.{type Effect}
import lustre/element
import lustre/element/html
import lustre/event
import sketch/styles/cfb_watcher_styles as styles
import utils/url

pub fn main() {
  let app = lustre.application(init, update, view)
  let assert Ok(_) = lustre.start(app, "#app", Nil)

  Nil
}

fn init(_flags) -> #(Model, Effect(Msg)) {
  #(
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
      command_dialog_valid: False,
    ),
    effect.none(),
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
    command_dialog_valid: Bool,
  )
}

pub opaque type Msg {
  UserFocusedVideo(CfbGame)
  UserRemovedVideo(CfbGame)
  UserOpenedCommandDialog
  UserClosedCommandDialog
  UserInputtedCommandDialog(String)
  UserSubmittedCommandDialog
}

pub fn update(model: Model, msg: Msg) -> #(Model, Effect(Msg)) {
  case msg {
    UserInputtedCommandDialog(value) -> {
      case url.youtube_url_valid(value) {
        True -> #(
          Model(
            ..model,
            command_dialog_value: value,
            command_dialog_valid: True,
          ),
          effect.none(),
        )
        False -> #(
          Model(
            ..model,
            command_dialog_value: value,
            command_dialog_valid: False,
          ),
          effect.none(),
        )
      }
    }
    UserSubmittedCommandDialog -> {
      case url.youtube_url_valid(model.command_dialog_value) {
        False -> #(
          Model(
            ..model,
            command_dialog_value: model.command_dialog_value,
            command_dialog_valid: False,
          ),
          effect.none(),
        )
        True -> {
          let assert Ok(video_id) =
            url.extract_youtube_id(model.command_dialog_value)
          let new_game = CfbGame(video_id: video_id)

          #(
            Model(
              games: [new_game, ..model.games],
              command_dialog_value: "",
              command_dialog_visible: False,
              command_dialog_valid: False,
            ),
            effect.none(),
          )
        }
      }
    }
    UserClosedCommandDialog -> {
      #(
        Model(..model, command_dialog_value: "", command_dialog_visible: False),
        effect.none(),
      )
    }
    UserOpenedCommandDialog -> {
      #(
        Model(..model, command_dialog_value: "", command_dialog_visible: True),
        command_dialog.focus_command_dialog_input_effect(),
      )
    }
    UserRemovedVideo(cfb_game) -> #(
      Model(
        ..model,
        games: list.filter(model.games, fn(game) { game != cfb_game }),
      ),
      effect.none(),
    )
    UserFocusedVideo(cfb_game) -> {
      let assert Ok(first_game) = list.first(model.games)
      case first_game == cfb_game {
        True -> {
          video.unmute(first_game.video_id)
          #(Model(..model, games: model.games), effect.none())
        }
        False -> {
          video.mute(first_game.video_id)
          video.unmute(cfb_game.video_id)
          #(
            Model(
              ..model,
              games: list.flatten([
                [CfbGame(video_id: cfb_game.video_id)],
                list.filter(model.games, fn(game) { game != cfb_game }),
              ]),
            ),
            effect.none(),
          )
        }
      }
    }
  }
}

pub fn view(model: Model) -> element.Element(Msg) {
  html.div([attribute.class(styles.container)], [
    curtain_button(),
    command_dialog(
      visible: model.command_dialog_visible,
      input_value: model.command_dialog_value,
      is_valid: model.command_dialog_valid,
    ),
    video_panel(model.games),
  ])
}

fn command_dialog(
  visible visible: Bool,
  input_value input_value: String,
  is_valid is_valid: Bool,
) {
  command_dialog.new(
    msg: UserClosedCommandDialog,
    visible: visible,
    placeholder: "Enter a valid YouTube URL",
    input_value: input_value,
    is_valid: is_valid,
    submit_attributes: [event.on_click(UserSubmittedCommandDialog)],
    cancel_attributes: [event.on_click(UserClosedCommandDialog)],
    input_attributes: [
      event.on_input(fn(value: String) { UserInputtedCommandDialog(value) }),
    ],
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
  curtain_button.new(UserOpenedCommandDialog, [
    event.on_click(UserOpenedCommandDialog),
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
  video.new(
    game.video_id,
    url.format_youtube_video_url(video_id: game.video_id, muted: muted),
  )
  |> video.view
}

fn video_overlay_view(game: CfbGame) -> element.Element(Msg) {
  video_overlay.new(
    UserFocusedVideo(game),
    [event.on_click(UserFocusedVideo(game))],
    [event.on_click(UserRemovedVideo(game))],
  )
  |> video_overlay.view
}
