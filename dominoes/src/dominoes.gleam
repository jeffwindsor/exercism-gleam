// TODO
import gleam/list.{any, permutations}

fn is_chain(chain: List(#(Int, Int))) -> Bool {
  case chain {
    // empty test
    [] -> True
    // singleton test
    [#(left, right)] -> left == right
    // treat current chain as a single dominoe of the two chain ends 
    [a, b, ..chain] if a.0 == b.0 -> is_chain([#(a.1, b.1), ..chain])
    [a, b, ..chain] if a.0 == b.1 -> is_chain([#(a.1, b.0), ..chain])
    [a, b, ..chain] if a.1 == b.0 -> is_chain([#(a.0, b.1), ..chain])
    [a, b, ..chain] if a.1 == b.1 -> is_chain([#(a.0, b.0), ..chain])
    // quit because dominoes not in a chainable order
    _ -> False
  }
}

pub fn can_chain(chain: List(#(Int, Int))) -> Bool {
  // check if any order of input is chainable
  chain |> permutations |> any(is_chain)
}
