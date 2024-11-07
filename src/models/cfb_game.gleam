import gleam/dynamic
import gleam/json
import gleam/list
import lib/storage
import lustre/effect

pub type CfbGame {
  CfbGame(video_id: String)
}

pub fn to_json(games: List(CfbGame)) -> String {
  json.array(from: list.map(games, fn(game) { game.video_id }), of: json.string)
  |> json.to_string
}

pub fn from_json(json: String) {
  case json.decode(json, dynamic.list(of: dynamic.string)) {
    Ok(video_ids) -> list.map(video_ids, fn(video_id) { CfbGame(video_id) })
    _ -> []
  }
}

pub fn save(cfb_games: List(CfbGame)) {
  storage.set_item("cfb_games", to_json(cfb_games))
}

pub fn save_effect(cfb_games: List(CfbGame)) {
  effect.from(fn(_) {
    save(cfb_games)
    Nil
  })
}

pub fn load() -> List(CfbGame) {
  case storage.get_item("cfb_games") {
    Ok(games_json) -> from_json(games_json)
    _ -> []
  }
}
