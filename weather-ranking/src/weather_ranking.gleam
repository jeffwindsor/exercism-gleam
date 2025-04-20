import gleam/float
import gleam/list
import gleam/order.{type Order}

pub type City {
  City(name: String, temperature: Temperature)
}

pub type Temperature {
  Celsius(Float)
  Fahrenheit(Float)
}

pub fn fahrenheit_to_celsius(f: Float) -> Float {
  { f -. 32.0 } /. 1.8
}

pub fn compare_temperature(left: Temperature, right: Temperature) -> Order {
  case left, right {
    Celsius(c1), Celsius(c2) -> float.compare(c1, c2)
    Fahrenheit(f1), Fahrenheit(f2) -> float.compare(f1, f2)
    Celsius(c1), Fahrenheit(f2) -> float.compare(c1, fahrenheit_to_celsius(f2))
    Fahrenheit(f1), Celsius(c2) -> float.compare(fahrenheit_to_celsius(f1), c2)
  }
}

pub fn sort_cities_by_temperature(cities: List(City)) -> List(City) {
  cities
  |> list.sort(fn(c1, c2) {
    compare_temperature(c1.temperature, c2.temperature)
  })
}
