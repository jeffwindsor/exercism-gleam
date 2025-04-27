import gleam/dict.{values}
import gleam/int.{compare, to_string}
import gleam/list.{flat_map, group, map, prepend, sort}
import gleam/string.{join, length, repeat, split}

type TeamScore {
  TeamScore(
    name: String,
    matches: Int,
    wins: Int,
    draws: Int,
    losses: Int,
    points: Int,
  )
}

pub fn tally(input: String) -> String {
  split(input, "\n")
  |> flat_map(parse_input_line)
  |> group(fn(a) { a.name })
  |> values
  |> map(append_team_scores)
  // out put needs to be teams by with most points first
  |> sort(fn(a, b) { compare(b.points, a.points) })
  |> map(to_tally_line)
  |> prepend("Team                           | MP |  W |  D |  L |  P")
  |> join("\n")
}

fn to_tally_line(ts: TeamScore) -> String {
  let column = fn(v) { repeat(" ", 3 - length(to_string(v))) <> to_string(v) }
  [
    ts.name <> repeat(" ", 30 - length(ts.name)),
    column(ts.matches),
    column(ts.wins),
    column(ts.draws),
    column(ts.losses),
    column(ts.points),
  ]
  |> join(" |")
}

fn append_team_scores(scores: List(TeamScore)) -> TeamScore {
  let empty = TeamScore("", 0, 0, 0, 0, 0)
  scores
  |> list.fold(empty, fn(acc, next) {
    TeamScore(
      name: next.name,
      matches: next.matches + acc.matches,
      wins: next.wins + acc.wins,
      draws: next.draws + acc.draws,
      losses: next.losses + acc.losses,
      points: next.points + acc.points,
    )
  })
}

fn parse_input_line(line: String) -> List(TeamScore) {
  let win = fn(team) { TeamScore(team, 1, 1, 0, 0, 3) }
  let loss = fn(team) { TeamScore(team, 1, 0, 0, 1, 0) }
  let draw = fn(team) { TeamScore(team, 1, 0, 1, 0, 1) }
  case line |> string.split(";") {
    [t1, t2, "win"] -> [win(t1), loss(t2)]
    [t1, t2, "loss"] -> [loss(t1), win(t2)]
    [t1, t2, "draw"] -> [draw(t1), draw(t2)]
    _ -> []
  }
}
