import gleam/list.{map}
import gleam/result.{values}
import gleam/string.{first, join, split, uppercase}

pub fn abbreviate(phrase phrase: String) -> String {
  phrase
  |> string.replace("-", " ")
  |> string.replace("_", " ")
  |> split(" ")
  |> map(first)
  |> values
  |> join("")
  |> uppercase
}
