import gleam/list
import gleam/string
import simplifile

pub fn read_emails(path: String) -> Result(List(String), Nil) {
  case simplifile.read(path) {
    Ok(emails) -> Ok(emails |> string.trim() |> string.split("\n"))
    Error(_) -> Error(Nil)
  }
}

pub fn create_log_file(path: String) -> Result(Nil, Nil) {
  case simplifile.write(to: path, contents: "") {
    Ok(_) -> Ok(Nil)
    Error(_) -> Error(Nil)
  }
}

pub fn log_sent_email(path: String, email: String) -> Result(Nil, Nil) {
  case simplifile.append(to: path, contents: email <> "\n") {
    Ok(_) -> Ok(Nil)
    Error(_) -> Error(Nil)
  }
}

pub fn send_newsletter(
  emails_path: String,
  log_path: String,
  send_email: fn(String) -> Result(Nil, Nil),
) -> Result(Nil, Nil) {
  case create_log_file(log_path) {
    Ok(_) ->
      case read_emails(emails_path) {
        Ok(emails) -> {
          list.each(emails, fn(e) {
            case send_email(e) {
              Ok(_) -> log_sent_email(log_path, e)
              _ -> Error(Nil)
            }
          })
          Ok(Nil)
        }
        _ -> Error(Nil)
      }
    _ -> Error(Nil)
  }
}
