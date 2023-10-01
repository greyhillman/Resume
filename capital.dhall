let Prelude = https://prelude.dhall-lang.org/v22.0.0/package.dhall

let contact = ./src/contact.dhall

let html = ./src/html/package.dhall

let Capital = ./src/types/capital/package.dhall

let capital = ./src/capital/package.dhall

let Job = Capital.Experience.Job.Type

let Project = Capital.Experience.Project

let Period = ./src/types/Period.dhall

let JobEndorsement = ./src/types/capital/Job/Endorsement.dhall

let KnowledgeUsage = ./src/types/capital/Job/KnowledgeUsage.dhall

let Scholarship = ./src/types/capital/Scholarship.dhall

let Degree = ./src/types/capital/Degree.dhall

let header =
      ''
      <h1>${contact.name}</h1>
      <address>
        <section>
            <span class="location">Victoria, BC</span>
            <a href="mailto:${contact.email}">${contact.email}</a>
        </section>
      </address>
      ''

let knowledge =
      \(data : KnowledgeUsage) ->
        let usage =
              merge
                { None = "none", Low = "low", Medium = "medium", High = "high" }
                data.usage

        in  ''
            <span class="knowledge ${usage}">${data.knowledge}</span>
            ''

let job =
      \(job : Job) ->
        let skill = \(skill : Text) -> "<li>${skill}</li>"

        let skills = Prelude.Text.concatMap Text skill job.skills

        let contract =
              merge
                { Coop = "Co-op", Permanent = "Permanent" }
                job.position.contract

        let endorsement =
              \(data : JobEndorsement) ->
                let relation =
                      merge
                        { Coworker = "Co-worker", Boss = "Boss" }
                        data.person.relation

                in  ''
                    <q>${data.quote}</q>
                    <span class="name">${data.person.name}</span>
                    <span class="position">${data.person.position}</span>
                    <span class="relation">${relation}</span>
                    ''

        let endorsements =
              Prelude.Text.concatMap
                JobEndorsement
                (\(x : JobEndorsement) -> "<li>${endorsement x}</li>")
                job.endorsements

        let knowledges =
              Prelude.Text.concatMap
                KnowledgeUsage
                (\(x : KnowledgeUsage) -> "<li>${knowledge x}</li>")
                job.knowledge

        in  ''
            <header>
                <span class="company">${job.company}</span>
                <section class="position">
                    <span>${job.position.title}</span>
                    -
                    <span>${contract}</span>
                </section>
                ${html.period job.period}
            </header>
            <section class="skills">
                <header>Skills</header>
                <ul>
                ${skills}
                </ul>
            </section>

            <section class="endorsements">
                <header>Endorsements</header>
                <ul>${endorsements}</ul>
            </section>

            <section class="knowledge">
                <header>Knowledge</header>
                <ul>${knowledges}</ul>
            </section>
            ''

let jobs =
      Prelude.Text.concatMap
        Job
        (\(x : Job) -> "<li>${job x}</li>")
        [ capital.experience.jobs.xplor.intermediate
        , capital.experience.jobs.xplor.junior
        , capital.experience.jobs.helmOperations.dev
        , capital.experience.jobs.helmOperations.coop
        , capital.experience.jobs.latitude
        , capital.experience.jobs.uvicCivil
        , capital.experience.jobs.demonware
        ]

let project =
      \(project : Project.Type) ->
        let link =
              merge
                { None = ""
                , Some =
                    \(link : Text) ->
                      ''
                      <a href="${link}">(link)</a>
                      ''
                }
                project.link

        let repo =
              merge
                { None = ""
                , Some =
                    \(repo : Text) ->
                      ''
                      <a href="${repo}">(repo)</a>
                      ''
                }
                project.repo

        let skills =
              Prelude.Text.concatMap
                Text
                (\(skill : Text) -> "<li>${skill}</li>")
                project.skills

        let knowledges =
              Prelude.Text.concatMap
                KnowledgeUsage
                (\(x : KnowledgeUsage) -> "<li>${knowledge x}</li>")
                project.knowledge

        in  ''
            <section class="project">
                <header>${project.title}</header>
                <aside>
                    ${link}
                    ${repo}
                </aside>
                <p>${project.purpose}</p>
                <section class="skills">
                    <header>Skills</header>
                    <ul>
                        ${skills}
                    </ul>
                </section>
                <section class="knowledge">
                    <header>Knowledge</header>
                    <ul>
                        ${knowledges}
                    </ul>
                </section>
            </section>
            ''

let projects =
      Prelude.Text.concatMap
        Project.Type
        (\(x : Project.Type) -> "<li>${project x}</li>")
        [ capital.experience.projects.blog
        , capital.experience.projects.finance
        , capital.experience.projects.rentBuy
        , capital.experience.projects.resume
        ]

let degree =
      \(degree : Degree) ->
        ''
        <section class="degree">
            <header>${degree.title}</header>
            <span class="faculty">${degree.faculty}</span>
            <span class="institution">${degree.university}</span>
            ${html.period degree.period}
        </section>
        ''

let degrees =
      Prelude.Text.concatMap
        Degree
        (\(x : Degree) -> "<li>${degree x}</li>")
        [ capital.knowledge.eduction.uvic.bachelors ]

let scholarship =
      \(scholarship : Scholarship) ->
        ''
        <section class="scholarship">
            <header>${scholarship.name}</header>
            <span class="year">${Natural/show scholarship.year}</span>
            <span class="institution">${scholarship.institution}</span>
            <span class="amount">$${Natural/show scholarship.amount}</span>
        </section>
        ''

let scholarships =
      Prelude.Text.concatMap
        Scholarship
        (\(x : Scholarship) -> "<li>${scholarship x}</li>")
        capital.knowledge.eduction.scholarships

in  ''
    <html>
        <head>
            <link href="./capital.css" rel="stylesheet" />
        </head>
        <body>
            <header>Human Capital</header>
            <main>
                <header>
                    ${header}
                </header>
                <article id="experience">
                    <header>Experience</header>

                    <section>
                        <header>Jobs</header>
                        <ol id="jobs">
                            ${jobs}
                        </ol>
                    </section>
                    <section>
                        <header>Projects</header>
                        <ul id="projects">
                            ${projects}
                        </ul>
                    </section>
                </article>
                <article id="education">
                    <header>Education</header>

                    <section>
                        <header>Degrees</header>

                        <ul>
                            ${degrees}
                        </ul>
                    </section>

                    <section>
                        <header>Scholarships</header>

                        <ul>
                            ${scholarships}
                        </ul>
                    </section>
                </article>
            </main>
        </body>
    </html>
    ''
