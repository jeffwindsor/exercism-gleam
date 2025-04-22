import gleam/queue.{type Queue}

pub opaque type CircularBuffer(t) {
  CircularBuffer(items: Queue(t), capacity: Int)
}

pub fn new(capacity: Int) -> CircularBuffer(t) {
  CircularBuffer(items: queue.new(), capacity: capacity)
}

pub fn read(buffer: CircularBuffer(t)) -> Result(#(t, CircularBuffer(t)), Nil) {
  case queue.pop_front(buffer.items) {
    Ok(#(item, new_queue)) -> {
      let new_buffer =
        CircularBuffer(items: new_queue, capacity: buffer.capacity)
      Ok(#(item, new_buffer))
    }
    Error(_) -> Error(Nil)
  }
}

pub fn write(
  buffer: CircularBuffer(t),
  item: t,
) -> Result(CircularBuffer(t), Nil) {
  case queue.length(buffer.items) < buffer.capacity {
    True -> {
      let new_queue = queue.push_back(buffer.items, item)
      Ok(CircularBuffer(items: new_queue, capacity: buffer.capacity))
    }
    False -> Error(Nil)
  }
}

pub fn overwrite(buffer: CircularBuffer(t), item: t) -> CircularBuffer(t) {
  let is_full = queue.length(buffer.items) == buffer.capacity
  let items = case is_full {
    True -> {
      let assert Ok(#(_, items)) = queue.pop_front(buffer.items)
      items
    }
    False -> buffer.items
  }
  items
  |> queue.push_back(item)
  |> fn(new_items) { CircularBuffer(..buffer, items: new_items) }
}

pub fn clear(buffer: CircularBuffer(t)) -> CircularBuffer(t) {
  CircularBuffer(items: queue.new(), capacity: buffer.capacity)
}
