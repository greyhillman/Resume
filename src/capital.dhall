-- General format can be taken from Economics
-- Human Capital is
--    - Knowledge
--    - Skills
--    - Experience
let languages = ./capital/languages.dhall

let databases = ./capital/databases.dhall

let frameworks = ./capital/frameworks.dhall

let tools = ./capital/tools.dhall

let methodologies = ./capital/methodologies.dhall

let companies = ./capital/companies/package.dhall

in  { experience = { companies, projects = ./capital/projects/package.dhall }
    , knowledge =
      { eduction = ./capital/education.dhall
      , languages
      , databases
      , frameworks
      , tools
      , methodologies
      }
    }
