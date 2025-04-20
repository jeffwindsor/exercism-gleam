pub fn is_leap_year(year: Int) -> Bool {
  let four = year % 4 == 0
  let hundo = year % 100 == 0
  let four_hundo = year % 400 == 0

  { four && !hundo } || { four && hundo && four_hundo }
}
