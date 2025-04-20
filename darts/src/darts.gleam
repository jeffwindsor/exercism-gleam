pub fn score(x: Float, y: Float) -> Int {
  let point_radius_squared = { x *. x } +. { y *. y }
  case point_radius_squared {
    // inner circle
    r if r <=. 1.0 && r >=. 0.0 -> 10
    // middle circle
    r if r <=. 25.0 && r >. 1.0 -> 5
    // outer circle
    r if r <=. 100.0 && r >. 25.0 -> 1
    // miss
    _ -> 0
  }
}
