let Month = ./Month.dhall

let Point = { month : Month, year : Natural }

let Past = { start : Point, end : Point }

let Current = { start : Point }

let Period = < Past : Past | Current : Current >

in  { Type = Period
    , Past
    , Current
    , Point
    , past = Period.Past
    , current =
        \(year : Natural) ->
        \(month : Month) ->
          Period.Current { start = { month, year } }
    , point = \(year : Natural) -> \(month : Month) -> { year, month } : Point
    }
