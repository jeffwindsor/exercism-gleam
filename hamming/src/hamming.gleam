import gleam/list
import gleam/result
import gleam/string

fn hamming(nucleotides: List(#(String, String))) {
  nucleotides
  |> list.filter(fn(ns) { ns.0 != ns.1 })
  |> list.length
}

pub fn distance(strand1: String, strand2: String) -> Result(Int, Nil) {
  list.strict_zip(string.to_graphemes(strand1), string.to_graphemes(strand2))
  |> result.map(hamming)
  |> result.nil_error
}
