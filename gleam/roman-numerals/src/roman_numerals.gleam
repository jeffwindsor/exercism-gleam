import gleam/string.{append}

pub fn convert(number: Int) -> String {
  convert_inner(number, "")
}

fn convert_inner(n: Int, acc: String) -> String {
  case n {
    _ if n >= 1000 -> convert_inner(n - 1000, append(acc, "M"))
    _ if n >= 900 -> convert_inner(n - 900, append(acc, "CM"))
    _ if n >= 500 -> convert_inner(n - 500, append(acc, "D"))
    _ if n >= 400 -> convert_inner(n - 400, append(acc, "CD"))
    _ if n >= 100 -> convert_inner(n - 100, append(acc, "C"))
    _ if n >= 90 -> convert_inner(n - 90, append(acc, "XC"))
    _ if n >= 50 -> convert_inner(n - 50, append(acc, "L"))
    _ if n >= 40 -> convert_inner(n - 40, append(acc, "XL"))
    _ if n >= 10 -> convert_inner(n - 10, append(acc, "X"))
    _ if n >= 9 -> convert_inner(n - 9, append(acc, "IX"))
    _ if n >= 5 -> convert_inner(n - 5, append(acc, "V"))
    _ if n >= 4 -> convert_inner(n - 4, append(acc, "IV"))
    _ if n >= 1 -> convert_inner(n - 1, append(acc, "I"))
    _ -> acc
  }
}
