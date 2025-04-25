// import gleam/io
import gleam/regex
import gleam/string

pub fn clean(input: String) -> Result(String, String) {
  case regex.from_string("[\\s\\-()\\.\\+]+") {
    Ok(rx) -> {
      let digits = input |> regex.replace(each: rx, with: "")

      case string.length(digits) {
        10 -> {
          // io.println("match 10")
          // io.debug(digits)
          let area_code = string.slice(digits, 0, 3)
          let number = string.slice(digits, 3, 7)
          case area_code, number {
            "1" <> _, _ -> Error("area code cannot start with one")
            "0" <> _, _ -> Error("area code cannot start with zero")
            _, "1" <> _ -> Error("exchange code cannot start with one")
            _, "0" <> _ -> Error("exchange code cannot start with zero")
            _, "@" <> _ -> Error("punctuations not permitted")
            _, "a" <> _ -> Error("letters not permitted")
            _, _ -> Ok(digits)
          }
        }
        11 -> {
          // io.println("match 11")
          // io.debug(digits)
          case digits {
            "1" <> rest -> clean(rest)
            _ -> Error("11 digits must start with 1")
          }
        }
        l if l < 10 -> {
          // io.println("less than 10")
          // io.debug(digits)
          Error("must not be fewer than 10 digits")
        }
        _ -> {
          // io.println("greater than 11")
          // io.debug(digits)
          Error("must not be greater than 11 digits")
        }
      }
    }
    Error(_) -> Error("Error in regex")
  }
}
