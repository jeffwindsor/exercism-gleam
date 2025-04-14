import gleam/float.{to_string}
import gleam/int.{to_float}
import gleam/string.{concat}

pub fn pence_to_pounds(pence: Int) -> Float {
  to_float(pence) /. 100.0
}

pub fn pounds_to_string(pounds: Float) -> String {
  concat(["£", to_string(pounds)])
}
