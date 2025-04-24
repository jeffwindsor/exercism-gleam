import gleam/dict.{type Dict}
import gleam/int
import gleam/list
import gleam/order.{type Order, Eq}
import gleam/string

pub type School =
  Dict(String, Int)

pub fn create() -> School {
  dict.new()
}

// student names
pub fn roster(school: School) -> List(String) {
  school
  |> dict.to_list()
  |> list.sort(student_grade_compare)
  |> list.map(fn(t) { t.0 })
}

pub fn add(
  to school: School,
  student student: String,
  grade grade: Int,
) -> Result(School, Nil) {
  case school |> dict.has_key(student) {
    // student strings are unique
    True -> Error(Nil)
    False -> school |> dict.insert(student, grade) |> Ok
  }
}

pub fn grade(school: School, desired_grade: Int) -> List(String) {
  school
  // to list of #(student, grade)
  |> dict.to_list()
  // only returns students in the desired grade
  |> list.filter_map(fn(item) {
    case item {
      #(student, grade) if grade == desired_grade -> Ok(student)
      _ -> Error(Nil)
    }
  })
}

fn student_grade_compare(a: #(String, Int), b: #(String, Int)) -> Order {
  // sort by grade, then name
  case int.compare(a.1, b.1) {
    Eq -> string.compare(a.0, b.0)
    order -> order
  }
}
