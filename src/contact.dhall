let Contact = ./types/Contact.dhall

let name = env:RESUME_NAME as Text

let address = env:RESUME_ADDRESS as Text

let email = env:RESUME_EMAIL as Text

in    { name
      , address
      , email
      , accounts =
        [ let username = "greyhillman"

          in  { site = "GitHub"
              , username
              , link = "https://github.com/${username}"
              }
        , let username = "greyhillman"

          in  { site = "LinkedIn"
              , username
              , link = "https://www.linkedin.com/in/${username}/"
              }
        ]
      }
    : Contact
