import gleam/list as l
import gleam/string as s

const space: String = " "

const separator: String = "\n"

type Letter {
  IndexedLetter(index: Int, char: String)
  InvalidLetter
}

pub fn build(letter: String) -> String {
  let build_letter = from_letter(letter)
  case build_letter {
    InvalidLetter -> ""
    IndexedLetter(index, _) if index == 0 -> {
      to_line(build_letter, 1)
    }
    IndexedLetter(index, _) -> {
      let length = 1 + { index * 2 }
      let lines =
        l.range(0, index - 1)
        |> l.map(fn(i) { to_line(from_index(i), length) })

      s.join(lines, separator)
      <> separator
      <> to_line(build_letter, length)
      <> separator
      <> s.join(l.reverse(lines), separator)
    }
  }
}

fn to_line(line_letter: Letter, line_length: Int) {
  let number_of_sides = 2
  case line_letter {
    InvalidLetter -> ""
    IndexedLetter(index, char) if index == 0 -> {
      let number_of_chars = 1
      let outer_spaces = { line_length - number_of_chars } / number_of_sides
      s.repeat(space, times: outer_spaces)
      <> char
      <> s.repeat(space, times: outer_spaces)
    }
    IndexedLetter(index, char) -> {
      let number_of_chars = 2
      let inner_spaces = 1 + { { index - 1 } * 2 }
      let outer_spaces =
        { line_length - { inner_spaces + number_of_chars } } / number_of_sides
      s.repeat(space, times: outer_spaces)
      <> char
      <> s.repeat(space, times: inner_spaces)
      <> char
      <> s.repeat(space, times: outer_spaces)
    }
  }
}

fn from_letter(letter: String) -> Letter {
  case letter {
    "A" -> IndexedLetter(0, "A")
    "B" -> IndexedLetter(1, "B")
    "C" -> IndexedLetter(2, "C")
    "D" -> IndexedLetter(3, "D")
    "E" -> IndexedLetter(4, "E")
    "F" -> IndexedLetter(5, "F")
    "G" -> IndexedLetter(6, "G")
    "H" -> IndexedLetter(7, "H")
    "I" -> IndexedLetter(8, "I")
    "J" -> IndexedLetter(9, "J")
    "K" -> IndexedLetter(10, "K")
    "L" -> IndexedLetter(11, "L")
    "M" -> IndexedLetter(12, "M")
    "N" -> IndexedLetter(13, "N")
    "O" -> IndexedLetter(14, "O")
    "P" -> IndexedLetter(15, "P")
    "Q" -> IndexedLetter(16, "Q")
    "R" -> IndexedLetter(17, "R")
    "S" -> IndexedLetter(18, "S")
    "T" -> IndexedLetter(19, "T")
    "U" -> IndexedLetter(20, "U")
    "V" -> IndexedLetter(21, "V")
    "W" -> IndexedLetter(22, "W")
    "X" -> IndexedLetter(23, "X")
    "Y" -> IndexedLetter(24, "Y")
    "Z" -> IndexedLetter(25, "Z")
    _ -> InvalidLetter
  }
}

fn from_index(index: Int) -> Letter {
  case index {
    0 -> IndexedLetter(0, "A")
    1 -> IndexedLetter(1, "B")
    2 -> IndexedLetter(2, "C")
    3 -> IndexedLetter(3, "D")
    4 -> IndexedLetter(4, "E")
    5 -> IndexedLetter(5, "F")
    6 -> IndexedLetter(6, "G")
    7 -> IndexedLetter(7, "H")
    8 -> IndexedLetter(8, "I")
    9 -> IndexedLetter(9, "J")
    10 -> IndexedLetter(10, "K")
    11 -> IndexedLetter(11, "L")
    12 -> IndexedLetter(12, "M")
    13 -> IndexedLetter(13, "N")
    14 -> IndexedLetter(14, "O")
    15 -> IndexedLetter(15, "P")
    16 -> IndexedLetter(16, "Q")
    17 -> IndexedLetter(17, "R")
    18 -> IndexedLetter(18, "S")
    19 -> IndexedLetter(19, "T")
    20 -> IndexedLetter(20, "U")
    21 -> IndexedLetter(21, "V")
    22 -> IndexedLetter(22, "W")
    23 -> IndexedLetter(23, "X")
    24 -> IndexedLetter(24, "Y")
    25 -> IndexedLetter(25, "Z")
    _ -> InvalidLetter
  }
}
