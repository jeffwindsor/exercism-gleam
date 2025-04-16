import gleam/int
import gleam/list
import gleam/result

pub type Resistance {
  Resistance(unit: String, value: Int)
}

type MetricUnit {
  MetricUnit(unit: String, multiplier: Int)
}

fn color_resistance(color: String) -> Result(Int, String) {
  case color {
    "black" -> Ok(0)
    "blue" -> Ok(6)
    "brown" -> Ok(1)
    "green" -> Ok(5)
    "grey" -> Ok(8)
    "orange" -> Ok(3)
    "red" -> Ok(2)
    "violet" -> Ok(7)
    "white" -> Ok(9)
    "yellow" -> Ok(4)
    _ -> Error("resistence color not known: " <> color)
  }
}

fn power_of_ten(exponent: Int) -> Int {
  case exponent {
    0 -> 1
    _ -> 10 * power_of_ten(exponent - 1)
  }
}

fn convert_to_metric(exponent: Int) -> Result(MetricUnit, String) {
  case exponent {
    0 | 1 | 2 -> Ok(MetricUnit("ohms", power_of_ten(exponent)))
    3 | 4 | 5 -> Ok(MetricUnit("kiloohms", power_of_ten(exponent - 3)))
    6 | 7 | 8 -> Ok(MetricUnit("megaohms", power_of_ten(exponent - 6)))
    9 | 10 | 11 -> Ok(MetricUnit("gigaohms", power_of_ten(exponent - 9)))
    _ ->
      Error(
        "10's exponent of " <> exponent |> int.to_string <> " is out of range",
      )
  }
}

pub fn label(colors: List(String)) -> Result(Resistance, Nil) {
  case colors |> list.map(color_resistance) {
    // spread effectively ignores extra colors
    [Ok(tens), Ok(ones), Ok(exp), ..] -> {
      // account for extra exponent if ones stripe is 0
      let #(base, exponent) = case ones {
        0 -> #(tens, exp + 1)
        _ -> #({ 10 * tens } + ones, exp)
      }
      case convert_to_metric(exponent) {
        Ok(mu) -> Ok(Resistance(mu.unit, base * mu.multiplier))
        _ -> Error(Nil)
      }
    }
    _ -> Error(Nil)
  }
}
