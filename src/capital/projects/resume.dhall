let Project = ../../types/capital/Project.dhall

let project =
        { title = "Resume"
        , link = None Text
        , repo = Some "https://github.com/greyhillman/Resume"
        , purpose = "To hold all resume data; change resume quickly & easily"
        }
      : Project

in      project
    /\  { highlights.dhall = "Learned Dhall to hold data & configure content" }
