-- General format can be taken from Economics
-- Human Capital is
--    - Knowledge
--    - Skills
--    - Experience
let Degree = ../types/capital/Degree.dhall

let Month = ../types/Month.dhall

let Period = ../types/Period.dhall

let uvicDegree =
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

let highschool =
      { name = "Mount Douglas High School"
      , period =
          Period.past
            { start = Period.point 2010 Month.Sep
            , end = Period.point 2014 Month.Jun
            }
      , highlights.apCourses = "Took 4 College Board Advanced Placement courses"
      }

in  { uvic.bachelors = uvicDegree
    , highschool
    , certifications = ./certifications.dhall
    , scholarships = ./scholarships.dhall
    }
