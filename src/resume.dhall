let capital = ./capital.dhall

let contact = ./contact.dhall

let Resume = ./types/resume/package.dhall

let employment = ./resume/employment.dhall

let knowledge =
      { education =
        [ let uvic = capital.knowledge.eduction.uvic.bachelors

          in  { title = uvic.title
              , from = "${uvic.university} - ${uvic.faculty}"
              , period = uvic.period
              , highlights = uvic.highlights
              }
        ]
      , other = ./resume/equipment.dhall
      }

let projects =
      let data = capital.experience.projects

      in    [ { title = data.finance.title
              , link = data.finance.link
              , repo = data.finance.repo
              , purpose = data.finance.purpose
              , highlights =
                [ data.finance.highlights.shake, data.finance.highlights.dhall ]
              }
            , { title = data.rentBuy.title
              , link = data.rentBuy.link
              , repo = data.rentBuy.repo
              , purpose = data.rentBuy.purpose
              , highlights = [ data.rentBuy.highlights.react ]
              }
            , { title = data.resume.title
              , link = data.resume.link
              , repo = data.resume.repo
              , purpose = data.resume.purpose
              , highlights = [ data.resume.highlights.dhall ] : List Text
              }
            ]
          : List Resume.Project

in  { contact, employment, knowledge, projects } : Resume.Type
