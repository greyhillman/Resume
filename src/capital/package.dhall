-- General format can be taken from Economics
-- Human Capital is
--    - Knowledge
--    - Skills
--    - Experience
let languages = ./languages.dhall

let databases = ./databases.dhall

let frameworks = ./frameworks.dhall

let tools = ./tools.dhall

let methodologies = ./methodologies.dhall

in  { experience =
      { jobs = ./companies/package.dhall, projects = ./projects/package.dhall }
    , knowledge =
      { eduction = ./education.dhall
      , languages
      , databases
      , frameworks
      , tools
      , methodologies
      }
    }
