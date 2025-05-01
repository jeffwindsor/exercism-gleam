import gleam/list.{filter_map, map, sized_chunk}
import gleam/string.{concat, join, lowercase, replace, to_graphemes}

pub fn encode(phrase: String) -> String {
  phrase
  |> to_graphemes
  |> filter_map(transpose_letter)
  |> sized_chunk(5)
  |> map(concat)
  |> join(" ")
}

pub fn decode(phrase: String) -> String {
  phrase
  |> replace(" ", "")
  |> to_graphemes
  |> filter_map(transpose_letter)
  |> concat
}

fn transpose_letter(c: String) {
  case lowercase(c) {
    "a" -> Ok("z")
    "b" -> Ok("y")
    "c" -> Ok("x")
    "d" -> Ok("w")
    "e" -> Ok("v")
    "f" -> Ok("u")
    "g" -> Ok("t")
    "h" -> Ok("s")
    "i" -> Ok("r")
    "j" -> Ok("q")
    "k" -> Ok("p")
    "l" -> Ok("o")
    "m" -> Ok("n")
    "n" -> Ok("m")
    "o" -> Ok("l")
    "p" -> Ok("k")
    "q" -> Ok("j")
    "r" -> Ok("i")
    "s" -> Ok("h")
    "t" -> Ok("g")
    "u" -> Ok("f")
    "v" -> Ok("e")
    "w" -> Ok("d")
    "x" -> Ok("c")
    "y" -> Ok("b")
    "z" -> Ok("a")
    " " | "." | "," -> Error(Nil)
    _ -> Ok(c)
  }
}
