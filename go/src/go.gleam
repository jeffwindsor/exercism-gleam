import gleam/result as r

pub type Player {
  Black
  White
}

pub type Game {
  Game(
    white_captured_stones: Int,
    black_captured_stones: Int,
    player: Player,
    error: String,
  )
}

fn next_player(player: Player) {
  case player {
    White -> Black
    Black -> White
  }
}

pub fn apply_rules(
  game: Game,
  rule1: fn(Game) -> Result(Game, String),
  rule2: fn(Game) -> Game,
  rule3: fn(Game) -> Result(Game, String),
  rule4: fn(Game) -> Result(Game, String),
) -> Game {
  case
    game
    |> rule2
    |> rule1
    |> r.try(rule3)
    |> r.try(rule4)
  {
    // -> If all rules pass, return a `Game` with all changes from the rules applied, and change player
    Ok(g) -> Game(..g, player: next_player(g.player))
    // -> If any rule fails, return the original Game, but with the error field set
    Error(s) -> Game(..game, error: s)
  }
}
