import gleam/string

pub fn extract_error(problem: Result(a, b)) -> b {
  let assert Error(message) = problem
  message
}

pub fn remove_team_prefix(team: String) -> String {
  string.replace(team, "Team ", "")
}

pub fn split_region_and_team(combined: String) -> #(String, String) {
  let assert [a, b] = string.split(combined, ",")
  #(a, remove_team_prefix(b))
}
