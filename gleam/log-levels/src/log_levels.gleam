import gleam/string as s

fn split(log_line: String) {
  s.split(log_line, "]")
}

pub fn log_level(log_line: String) -> String {
  case split(log_line) {
    [level, _] -> s.lowercase(s.trim(s.drop_left(level, 1)))
    _ -> "fail"
  }
}

pub fn message(log_line: String) -> String {
  case split(log_line) {
    [_, message] -> s.trim(s.drop_left(message, 2))
    _ -> "fail"
  }
}

pub fn reformat(log_line: String) -> String {
  message(log_line) <> " (" <> log_level(log_line) <> ")"
}
