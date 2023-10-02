-- General format can be taken from Economics
-- Human Capital is
--    - Knowledge
--    - Skills
--    - Experience
{ experience =
  { jobs = ./companies/package.dhall, projects = ./projects/package.dhall }
, knowledge.education = ./education.dhall
}
