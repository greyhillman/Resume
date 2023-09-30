-- General format can be taken from Economics
-- Human Capital is
--    - Knowledge
--    - Skills
--    - Experience
let Degree = ../types/capital/Degree.dhall

let Month = ../types/Month.dhall

let Period = ../types/Period.dhall

let PartialDate = ../types/capital/Date.dhall

let Scholarship = ../types/capital/Scholarship.dhall

let uvicDegree =
      let degree =
              { title = "Bachelor of Science (Honours) (Co-op)"
              , faculty = "Computer Science"
              , university = "University of Victoria"
              , period =
                  Period.past
                    { start = Period.point 2014 Month.Sep
                    , end = Period.point 2019 Month.Apr
                    }
              , highlights = [ "GPA: 8.5 / 9" ]
              }
            : Degree

      in      degree
          /\  { scholarships =
                { entrance =
                      [ { name = "UVic Entrance Scholarship"
                        , date = PartialDate.Year 2014
                        , amount = 3000
                        }
                      , { name = "Dean's Entrance Scholarship"
                        , date = PartialDate.Year 2014
                        , amount = 1000
                        }
                      ]
                    : List Scholarship
                , president =
                    let name = "President's Scholarship"

                    in    [ { name
                            , date = PartialDate.Year 2015
                            , amount = 3750
                            }
                          , { name
                            , date = PartialDate.Year 2016
                            , amount = 2000
                            }
                          , { name
                            , date = PartialDate.Year 2016
                            , amount = 2000
                            }
                          , { name
                            , date = PartialDate.Year 2017
                            , amount = 2000
                            }
                          , { name
                            , date = PartialDate.Year 2018
                            , amount = 4000
                            }
                          ]
                        : List Scholarship
                , others =
                      [ { name = "James Riddell Memorial Scholarship"
                        , date = PartialDate.Year 2015
                        , amount = 250
                        }
                      ]
                    : List Scholarship
                }
              }

let highschool =
      { name = "Mount Douglas High School"
      , period =
          Period.past
            { start = Period.point 2010 Month.Sep
            , end = Period.point 2014 Month.Jun
            }
      , highlights.apCourses = "Took 4 College Board Advanced Placement courses"
      }

in  { uvic.bachelors = uvicDegree, highschool }
