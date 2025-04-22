import gleam/list
import gleam/result
import gleam/string

fn convert(nucleotide) {
  case nucleotide {
    "G" -> Ok("C")
    "C" -> Ok("G")
    "T" -> Ok("A")
    "A" -> Ok("U")
    _ -> Error(Nil)
  }
}

pub fn to_rna(dna: String) -> Result(String, Nil) {
  case
    dna
    |> string.to_graphemes()
    |> list.map(convert)
    |> result.all()
  {
    Ok(ns) -> Ok(string.concat(ns))
    _ -> Error(Nil)
  }
}
