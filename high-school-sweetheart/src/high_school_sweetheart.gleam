import gleam/string

pub fn first_letter(name: String) {
  let chars = string.to_graphemes(string.trim(name))
  case chars {
    [first, ..] -> first
    _ -> ""
  }
}

pub fn initial(name: String) {
  string.uppercase(first_letter(name)) <> "."
}

pub fn initials(full_name: String) {
  case string.split(string.trim(full_name), " ") {
    [f, l] -> initial(f) <> " " <> initial(l)
    _ -> ""
  }
}

pub fn pair(full_name1: String, full_name2: String) {
  "
     ******       ******
   **      **   **      **
 **         ** **         **
**            *            **
**                         **
**     " <> initials(full_name1) <> "  +  " <> initials(full_name2) <> "     **
 **                       **
   **                   **
     **               **
       **           **
         **       **
           **   **
             ***
              *
"
}
