let Month = ./Month.dhall

let Point = { month : Month, year : Natural }

let Past = { start : Point, end : Point }

let Current = { start : Point }

let Period = < Past : Past | Current : Current >

in  { Type = Period
    , past = Period.Past
    , current = Period.Current
    , point = \(year : Natural) -> \(month : Month) -> { year, month } : Point
    }
