let Project = ../../types/capital/Project.dhall

let project =
        { title = "Rent vs. Buy Calculator"
        , link = Some "https://greyhillman.github.io/rent-vs-buy/"
        , repo = Some "https://github.com/greyhillman/rent-vs-buy"
        , purpose = "To help myself make important decision & convince others"
        }
      : Project

in      project
    /\  { highlights.react = "Learned React (with hooks) to build frontend" }
