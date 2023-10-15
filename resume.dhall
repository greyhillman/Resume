let Prelude = https://prelude.dhall-lang.org/v22.0.0/package.dhall

let Resume = ./src/types/Resume.dhall

let data = ./src/resume.dhall

let contact = ./src/contact.dhall

let online_account =
      \(site : Text) ->
      \(username : Text) ->
      \(link : Text) ->
        ''
        <span class="site">${site}</span>
        <a class="username" href="${link}">${username}</a>
        ''

let online_accounts =
      Prelude.Text.concatMap
        Text
        (\(x : Text) -> "<li>${x}</li>")
        [ online_account "GitHub" "greyhillman" "https://github.com/greyhillman"
        , online_account
            "LinkedIn"
            "greyhillman"
            "https://www.linkedin.com/in/greyhillman/"
        ]

let address =
      ''
      <address>
        <p>${contact.name}</p>
        <span class="location">Victoria, BC</span>
        <a href="mailto:${contact.email}">${contact.email}</a>

        <ul class="social">
            ${online_accounts}
        </ul>
      </address>
      ''

let job =
      \(job : Resume.Position) ->
        let highlights =
              Prelude.Text.concatMap
                Text
                (\(x : Text) -> "<li>${x}</li>")
                job.highlights

        let tech =
              Prelude.Text.concatMap
                Text
                (\(x : Text) -> "<li>${x}</li>")
                job.tech

        in  ''
            <header>${job.title}</header>
            <span class="company">${job.company}</span>
            <span class="period">${job.period}</span>

            <ul class="highlight">${highlights}</ul>
            <ul class="tech">${tech}</ul>
            ''

let jobs =
      Prelude.Text.concatMap
        Resume.Position
        (\(x : Resume.Position) -> "<li>${job x}</li>")
        data.positions

let project =
      \(project : Resume.Project) ->
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

        let highlights =
              Prelude.Text.concatMap
                Text
                (\(x : Text) -> "<li>${x}</li>")
                project.highlights

        let tech =
              Prelude.Text.concatMap
                Text
                (\(x : Text) -> "<li>${x}</li>")
                project.tech

        in  ''
            <header>${project.title}</header>
            <aside>
                ${link}
                ${repo}
            </aside>
            <p>Purpose: ${project.purpose}</p>
            <ul class="highlight">
                ${highlights}
            </ul>
            <ul class="tech">
                ${tech}
            </ul>
            ''

let projects =
      Prelude.Text.concatMap
        Resume.Project
        (\(x : Resume.Project) -> "<li>${project x}</li>")
        data.projects

let degree =
      ''
      <section class="degree">
          <header>${data.degree.title}</header>
          <aside class="period">${data.degree.period}</aside>
          <p class="institution">${data.degree.institution} - ${data.degree.faculty}</p>

      </section>
      ''

in  ''
    <html>
        <head>
            <link href="./resume.css" rel="stylesheet" />
        </head>
        <body>
            <main>
                <article>
                    ${address}
                    <section id="employment">
                        <header>Employment</header>
                        <ol class="job">
                            ${jobs}
                        </ol>
                    </section>
                    <section id="projects">
                        <header>Projects</header>
                        <ol>
                            ${projects}
                        </ol>
                    </section>
                    <section id="education">
                        <header>Education</header>
                        ${degree}
                    </section>
                </article>
                <footer>
                    References on request
                </footer>
            </main>
        </body>
    </html>
    ''
