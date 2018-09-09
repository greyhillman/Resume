let Project = ../../types/capital/Project.dhall

let project =
        { title = "Personal Finances System"
        , link = None Text
        , repo = None Text
        , purpose =
            "To track personal finances; automatically produce financial reports"
        }
      : Project

in      project
    /\  { highlights =
          { shake = "Used Haskell's Shake build system to generate reports"
          , dhall = "Learned Dhall to store financial data"
          }
        }
