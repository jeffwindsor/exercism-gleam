import gleam/int
import gleam/list

pub type Command {
  Wink
  DoubleBlink
  CloseYourEyes
  Jump
}

const reverse_bit_flag = 16

const command_bit_flags = [
  #(Wink, 1), #(DoubleBlink, 2), #(CloseYourEyes, 4), #(Jump, 8),
]

pub fn commands(encoded_message: Int) -> List(Command) {
  // commands with bit flag present
  let commands =
    command_bit_flags
    |> list.filter_map(fn(cbf) {
      case int.bitwise_and(cbf.1, encoded_message) {
        // Not present, filter out
        0 -> Error(Nil)
        // Present, map to command
        _ -> Ok(cbf.0)
      }
    })

  // if reverse bit flag is present then reverse the list
  case int.bitwise_and(reverse_bit_flag, encoded_message) {
    0 -> commands
    _ -> commands |> list.reverse
  }
}
