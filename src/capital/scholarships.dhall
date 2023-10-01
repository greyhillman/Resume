let Scholarship = ../types/capital/Scholarship.dhall

let uvic =
      let institution = "University of Victoria"

      let presidents =
            \(year : Natural) ->
            \(amount : Natural) ->
              { name = "President's Scholarship", institution, year, amount }

      in    [ { name = "UVic Entrance Scholarship"
              , institution
              , year = 2014
              , amount = 3000
              }
            , { name = "Dean's Entrance Scholarship"
              , institution
              , year = 2014
              , amount = 1000
              }
            , presidents 2015 3750
            , presidents 2016 2000
            , presidents 2016 2000
            , presidents 2017 2000
            , presidents 2018 4000
            , { name = "James Riddell Memorial Scholarship"
              , institution
              , year = 2015
              , amount = 250
              }
            ]
          : List Scholarship

in  uvic : List Scholarship
