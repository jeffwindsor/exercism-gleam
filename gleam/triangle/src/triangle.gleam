import gleam/list as l

type Triangle {
  Equilateral
  Isosceles
  Scalene
  NotATriangle
}

fn is_triangle_type(a: Float, b: Float, c: Float) -> Triangle {
  case
    { a >. 0.0 }
    && { b >. 0.0 }
    && { b >. 0.0 }
    && { a +. b >=. c }
    && { b +. c >=. a }
    && { a +. c >=. b }
  {
    True ->
      case l.count([a == b, b == c, c == a], fn(x) { x }) {
        3 -> Equilateral
        1 -> Isosceles
        _ -> Scalene
      }
    False -> NotATriangle
  }
}

pub fn equilateral(a: Float, b: Float, c: Float) -> Bool {
  is_triangle_type(a, b, c) == Equilateral
}

pub fn isosceles(a: Float, b: Float, c: Float) -> Bool {
  case is_triangle_type(a, b, c) {
    Equilateral -> True
    Isosceles -> True
    _ -> False
  }
}

pub fn scalene(a: Float, b: Float, c: Float) -> Bool {
  is_triangle_type(a, b, c) == Scalene
}
