import gleam/list
import gleam/result
import gleam/string

fn to_protien(nucleotides) {
  case nucleotides {
    "AUG" -> Ok("Methionine")
    "UGG" -> Ok("Tryptophan")
    "UUU" | "UUC" -> Ok("Phenylalanine")
    "UUA" | "UUG" -> Ok("Leucine")
    "UAU" | "UAC" -> Ok("Tyrosine")
    "UGU" | "UGC" -> Ok("Cysteine")
    "UAA" | "UAG" | "UGA" -> Ok("STOP")
    "UCU" | "UCC" | "UCA" | "UCG" -> Ok("Serine")
    _ -> Error(Nil)
  }
}

pub fn proteins(rna: String) -> Result(List(String), Nil) {
  rna
  |> string.to_graphemes
  |> list.sized_chunk(3)
  |> list.map(fn(nts) { to_protien(string.join(nts, "")) })
  |> fn(ps) {
    let #(a, _) = list.split_while(ps, fn(p) { p != Ok("STOP") })
    a
  }
  |> result.all()
}
