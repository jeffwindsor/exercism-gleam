import gleam/bit_array
import gleam/list
import gleam/result

pub type Nucleotide {
  Adenine
  Cytosine
  Guanine
  Thymine
}

const bit_size = 2

pub fn encode_nucleotide(nucleotide: Nucleotide) -> Int {
  case nucleotide {
    Adenine -> 0b00
    Cytosine -> 0b01
    Guanine -> 0b10
    Thymine -> 0b11
  }
}

pub fn decode_nucleotide(nucleotide: Int) -> Result(Nucleotide, Nil) {
  case nucleotide {
    0b00 -> Ok(Adenine)
    0b01 -> Ok(Cytosine)
    0b10 -> Ok(Guanine)
    0b11 -> Ok(Thymine)
    _ -> Error(Nil)
  }
}

pub fn encode(dna: List(Nucleotide)) -> BitArray {
  dna
  |> list.map(encode_nucleotide)
  |> list.map(fn(i) { <<i:size(bit_size)>> })
  |> list.fold(<<>>, bit_array.append)
}

pub fn decode(dna: BitArray) -> Result(List(Nucleotide), Nil) {
  case dna {
    // end case for recursion
    <<>> -> Ok([])
    // take bits off the front of the array
    <<d:size(bit_size), rest:bits>> -> {
      // unwraps were Ok put in h, Error short circuits
      use h <- result.try(decode_nucleotide(d))
      // recurse and unwrap
      use t <- result.try(decode(rest))
      Ok([h, ..t])
    }
    _ -> Error(Nil)
  }
}
