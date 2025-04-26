import gleam/dict
import gleam/int
import gleam/list.{flatten, group, map, prepend, sort}
import gleam/string.{join, length, split}

type TeamScore =
  #(String, Score)

type Score {
  Score(matches: Int, wins: Int, draws: Int, losses: Int, points: Int)
}

pub fn tally(input: String) -> String {
  let new_line = "\n"

  split(input, new_line)
  |> map(parse_line)
  |> flatten
  |> group(by_team_name)
  |> dict.to_list
  |> map(sum_team_scores)
  |> sort(by_points_descending)
  |> map(to_tally_line)
  |> prepend("Team                           | MP |  W |  D |  L |  P")
  |> join(new_line)
}

fn to_tally_line(team_score: TeamScore) -> String {
  let column = fn(v) {
    let n = int.to_string(v)
    let padding = string.repeat(" ", 3 - length(n))
    padding <> n
  }
  let #(name, score) = team_score
  let name_padding = string.repeat(" ", 30 - length(name))

  [
    name <> name_padding,
    column(score.matches),
    column(score.wins),
    column(score.draws),
    column(score.losses),
    column(score.points),
  ]
  |> join(" |")
}

fn by_points_descending(one: TeamScore, two: TeamScore) {
  int.compare({ two.1 }.points, { one.1 }.points)
}

fn by_team_name(team_score: TeamScore) {
  team_score.0
}

fn sum_team_scores(group: #(String, List(TeamScore))) {
  let empty = Score(0, 0, 0, 0, 0)
  let score =
    group.1
    |> list.fold(empty, fn(acc, team_score) {
      let next = team_score.1
      Score(
        matches: next.matches + acc.matches,
        wins: next.wins + acc.wins,
        draws: next.draws + acc.draws,
        losses: next.losses + acc.losses,
        points: next.points + acc.points,
      )
    })
  #(group.0, score)
}

// return two team scores per input line
fn parse_line(line: String) {
  let win = fn(team) { #(team, Score(1, 1, 0, 0, 3)) }
  let loss = fn(team) { #(team, Score(1, 0, 0, 1, 0)) }
  let draw = fn(team) { #(team, Score(1, 0, 1, 0, 1)) }
  case line |> string.split(";") {
    [t1, t2, "win"] -> [win(t1), loss(t2)]
    [t1, t2, "loss"] -> [loss(t1), win(t2)]
    [t1, t2, "draw"] -> [draw(t1), draw(t2)]
    _ -> []
  }
}
