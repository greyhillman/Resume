let PeriodDate = ./PeriodDate.dhall

let Month = ./Month.dhall

in  < Short : { year : Natural, start : Month, end : Month }
    | Long : { start : PeriodDate, end : PeriodDate }
    >
