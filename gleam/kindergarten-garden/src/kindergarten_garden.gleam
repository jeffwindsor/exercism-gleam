import gleam/list
import gleam/string

pub type Student {
  Alice
  Bob
  Charlie
  David
  Eve
  Fred
  Ginny
  Harriet
  Ileana
  Joseph
  Kincaid
  Larry
}

pub type Plant {
  Radishes
  Clover
  Violets
  Grass
}

fn student_index(student) {
  case student {
    Alice -> 0
    Bob -> 1
    Charlie -> 2
    David -> 3
    Eve -> 4
    Fred -> 5
    Ginny -> 6
    Harriet -> 7
    Ileana -> 8
    Joseph -> 9
    Kincaid -> 10
    Larry -> 11
  }
}

fn letter_to_plant(letter) {
  case letter {
    "R" -> Radishes
    "C" -> Clover
    "V" -> Violets
    _ -> Grass
  }
}

pub fn plants(diagram: String, student: Student) -> List(Plant) {
  diagram
  |> string.split("\n")
  |> list.map(fn(row) { string.slice(row, student_index(student) * 2, 2) })
  |> string.concat()
  |> string.to_graphemes
  |> list.map(letter_to_plant)
}
