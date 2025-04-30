import gleam/bool.{negate}
import gleam/list.{all, any, append, filter, prepend, unique}

pub opaque type Set(t) {
  Set(items: List(t))
}

pub fn new(members: List(t)) -> Set(t) {
  members |> unique |> Set
}

pub fn is_empty(set: Set(t)) -> Bool {
  set.items == []
}

pub fn contains(in set: Set(t), this member: t) -> Bool {
  set.items |> list.contains(member)
}

pub fn is_subset(first: Set(t), of second: Set(t)) -> Bool {
  first.items |> all(contains(second, _))
}

pub fn disjoint(first: Set(t), second: Set(t)) -> Bool {
  first.items |> any(contains(second, _)) |> negate
}

pub fn is_equal(first: Set(t), to second: Set(t)) -> Bool {
  is_subset(first, second) && is_subset(second, first)
}

pub fn add(to set: Set(t), this member: t) -> Set(t) {
  prepend(set.items, member) |> unique |> Set
}

pub fn intersection(of first: Set(t), and second: Set(t)) -> Set(t) {
  first.items |> filter(contains(second, _)) |> Set
}

pub fn difference(between first: Set(t), and second: Set(t)) -> Set(t) {
  first.items |> filter(fn(s) { !contains(second, s) }) |> Set
}

pub fn union(of first: Set(t), and second: Set(t)) -> Set(t) {
  first.items |> append(second.items) |> unique |> Set
}
