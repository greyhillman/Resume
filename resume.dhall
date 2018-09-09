let Prelude = https://prelude.dhall-lang.org/package.dhall

let data = ./src/resume.dhall

let contact = ./src/contact.dhall

let ContactAccount = ./src/types/ContactAccount.dhall

let html = ./src/html/package.dhall

let Types = ./src/types/resume/package.dhall

let from_social-media = html.social_account

let social_media_sites =
      Prelude.Text.concatMap ContactAccount from_social-media contact.accounts

let social_media =
      ''
      <ul class="social-media">
          ${social_media_sites}
      </ul>
      ''

let header =
      ''
      <h1>${contact.name}</h1>
      <address>
        <section>
            <span class="location">Victoria, BC</span>
            <a href="mailto:${contact.email}">${contact.email}</a>
        </section>
        ${social_media}
      </address>
      ''

let experience =
      let jobs = Prelude.Text.concatMap Types.Job html.job data.employment

      let projects =
            Prelude.Text.concatMap Types.Project html.project data.projects

      in  ''
          <section id="employment">
            <h1>Employment</h1>
            <ol>
                ${jobs}
            </ol>
          </section>
          <section id="projects">
            <h1>Projects</h1>
            <ul>
                ${projects}
            </ul>
          </section>
            ''

let knowledge =
      let areas =
            Prelude.Text.concatMap
              Types.Knowledge
              html.knowledge
              data.knowledge.other

      let educations =
            Prelude.Text.concatMap
              Types.Education
              html.education
              data.knowledge.education

      in  ''
          <section id="knowledge">
            <h1>Knowledge</h1>
            <ul id="education">
                ${educations}
            </ul>
            <ul id="equipment">
                ${areas}
            </ul>
          </section>
          ''

in  ''
    <html>
        <head>
            <link href="./resume.css" rel="stylesheet" />
        </head>
        <body>
            <article>
                <main>
                    <header>
                        ${header}
                    </header>
                    ${experience}
                    ${knowledge}
                </main>
            </article>
        </body>
    </html>
    ''
