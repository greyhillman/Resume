let Databases = ../types/Databases.dhall

in  { sql_server = "SQL Server", postgres = "PostgreSQL" } : Databases.Type Text
