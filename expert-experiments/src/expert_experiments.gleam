import gleam/result

pub fn with_retry(experiment: fn() -> Result(t, e)) -> Result(t, e) {
  case experiment() {
    Ok(r) -> Ok(r)
    Error(_) -> experiment()
  }
}

pub fn record_timing(
  time_logger: fn() -> Nil,
  experiment: fn() -> Result(t, e),
) -> Result(t, e) {
  time_logger()
  let exp_result = experiment()
  time_logger()
  exp_result
}

pub fn run_experiment(
  name: String,
  setup: fn() -> Result(t, e),
  action: fn(t) -> Result(u, e),
  record: fn(t, u) -> Result(v, e),
) -> Result(#(String, v), e) {
  use sr <- result.try(setup())
  use ar <- result.try(action(sr))
  case record(sr, ar) {
    Ok(recording_data) -> Ok(#(name, recording_data))
    Error(r) -> Error(r)
  }
}
