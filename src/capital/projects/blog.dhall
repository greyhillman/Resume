let Project = ../../types/capital/Project.dhall

let project =
        { title = "Personal Blog"
        , link = Some "https://greyhillman.github.io/"
        , repo = Some "https://github.com/greyhillman/greyhillman.github.io"
        , purpose =
            "To explain my ideas; teach others via explorable explanations"
        }
      : Project

in  project /\ { highlights = {} }
