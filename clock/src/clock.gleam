import gleam/int

const min_in_hour = 60

const mins_in_day = 1440

pub opaque type Clock {
  Clock(minutes: Int)
}

pub fn normalize(minutes: Int) -> Int {
  case minutes {
    m if m >= 0 && m < mins_in_day -> {
      // io.debug("within a day: " <> int.to_string(m))
      m
    }
    m if m >= mins_in_day -> {
      let value = m - { mins_in_day * { m / mins_in_day } }
      // io.debug(
      //   "over a day: "
      //   <> int.to_string(m)
      //   <> " converted to: "
      //   <> int.to_string(value),
      // )
      value
    }
    m -> {
      let m = int.absolute_value(m)
      let value =
        int.negate(m - { mins_in_day * { m / mins_in_day } }) + mins_in_day
      // io.debug(
      //   "under a day: "
      //   <> int.to_string(m)
      //   <> " converted to: "
      //   <> int.to_string(value),
      // )
      value
    }
  }
}

pub fn create(hour hour: Int, minute minute: Int) -> Clock {
  add(Clock(0), { hour * 60 } + minute)
}

pub fn add(clock: Clock, minutes minutes: Int) -> Clock {
  Clock(normalize(clock.minutes + minutes))
}

pub fn subtract(clock: Clock, minutes minutes: Int) -> Clock {
  Clock(normalize(clock.minutes - minutes))
}

fn format_2(value: Int) -> String {
  case value {
    v if v < 10 -> "0" <> int.to_string(v)
    v -> int.to_string(v)
  }
}

pub fn display(clock: Clock) -> String {
  let hours = clock.minutes / min_in_hour
  let minutes = clock.minutes - { hours * min_in_hour }
  format_2(hours) <> ":" <> format_2(minutes)
}
