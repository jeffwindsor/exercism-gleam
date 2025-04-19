import gleam/queue.{type Queue} as q

pub fn insert_top(queue: Queue(Int), card: Int) -> Queue(Int) {
  q.push_back(queue, card)
}

pub fn remove_top_card(queue: Queue(Int)) -> Queue(Int) {
  case q.pop_back(queue) {
    Ok(#(_, q)) -> q
    _ -> queue
  }
}

pub fn insert_bottom(queue: Queue(Int), card: Int) -> Queue(Int) {
  q.push_front(queue, card)
}

pub fn remove_bottom_card(queue: Queue(Int)) -> Queue(Int) {
  case q.pop_front(queue) {
    Ok(#(_, q)) -> q
    _ -> queue
  }
}

pub fn check_size_of_stack(queue: Queue(Int), target: Int) -> Bool {
  target == q.length(queue)
}
