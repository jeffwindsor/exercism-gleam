import gleam/list
import gleam/string

pub fn translate(phrase: String) -> String {
  phrase
  |> string.split(" ")
  |> list.map(encode)
  |> string.join(" ")
}

fn encode(phrase: String) -> String {
  case phrase {
    "ya" <> _ | "ye" <> _ | "yi" <> _ | "yo" <> _ | "yu" <> _ ->
      string.drop_left(phrase, 1) <> "yay"
    "a" <> _ | "e" <> _ | "i" <> _ | "o" <> _ | "u" <> _ | "xr" <> _ | "y" <> _ ->
      phrase <> "ay"
    "qu" <> rest -> translate(rest <> "qu")
    _ -> translate(string.drop_left(phrase, 1) <> string.slice(phrase, 0, 1))
  }
}
