import gleam/int

fn get_sound(number: Int, divisor: Int, sound: String) -> String {
  case int.remainder(number, divisor) {
    Ok(0) -> sound
    _ -> ""
  }
}

pub fn convert(number: Int) -> String {
  let sound =
    get_sound(number, 3, "Pling")
    <> get_sound(number, 5, "Plang")
    <> get_sound(number, 7, "Plong")

  case sound {
    "" -> int.to_string(number)
    _ -> sound
  }
}
