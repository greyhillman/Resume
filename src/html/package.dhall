let Prelude = https://prelude.dhall-lang.org/v22.0.0/package.dhall

let ContactAccount = ../types/ContactAccount.dhall

let Month = ../types/Month.dhall

let Period = ../types/Period.dhall

let PeriodDate = ../types/PeriodDate.dhall

let Data = ../types/resume/package.dhall

let month =
      \(month : Month) ->
        merge
          { Jan = "Jan"
          , Feb = "Feb"
          , Mar = "Mar"
          , Apr = "Apr"
          , May = "May"
          , Jun = "Jun"
          , Jul = "Jul"
          , Aug = "Aug"
          , Sep = "Sep"
          , Oct = "Oct"
          , Nov = "Nov"
          , Dec = "Dec"
          }
          month

let date =
      \(date : PeriodDate) -> "${month date.month} ${Natural/show date.year}"

let period =
      \(period : Period) ->
        merge
          { Short =
              \(short : { year : Natural, start : Month, end : Month }) ->
                    "${month short.start}-${month short.end} "
                ++  Natural/show short.year
          , Long =
              \(long : { start : PeriodDate, end : PeriodDate }) ->
                "${date long.start} - ${date long.end}"
          }
          period

let highlight = \(t : Text) -> "<li>${t}</li>"

let job_position =
      \(jp : Data.JobPosition) ->
        let period_html = period jp.period

        let html_highlights =
              Prelude.Text.concatMap Text highlight jp.highlights

        in  ''
            <li class="position">
              <h3>${jp.title}</h3>
              <aside>${period_html}</aside>
              <ul class="highlights">
                ${html_highlights}
              </ul>
            </li>
            ''

let job =
      \(job : Data.Job) ->
        let positions =
              Prelude.Text.concatMap Data.JobPosition job_position job.positions

        in  ''
            <li class="job">
              <h2>${job.company}</h2>
              <ol>
                ${positions}
              </ol>
            </li>
            ''

let project =
      \(proj : Data.Project) ->
        let link =
              merge
                { Some =
                    \(link : Text) ->
                      ''
                      <a href="${link}">(link)</a>
                      ''
                , None = ""
                }
                proj.link

        let repo =
              merge
                { Some =
                    \(link : Text) ->
                      ''
                      <a class="repo" href="${link}">(repo)</a>
                      ''
                , None = ""
                }
                proj.repo

        let title = "<h2>${proj.title}<aside>${link}${repo}</aside></h2>"

        let highlights =
              Prelude.Text.concatMap
                Text
                (\(t : Text) -> "<li>${t}</li>")
                proj.highlights

        in  ''
            <li class="project">
              ${title}
              <h3>Purpose: <span class="purpose">${proj.purpose}</span></h3>
              <ul class="highlights">
                ${highlights}
              </ul>
            </li>
            ''

let knowledge_level =
      \(kl : Data.KnowledgeLevel) ->
      \(content : Text) ->
        let level =
              merge
                { Basic = "basic"
                , Intermediate = "intermediate"
                , Advanced = "advanced"
                }
                kl

        in  ''
            <li class="${level}">${content}</li>
            ''

let knowledge =
      \(knowledge : Data.Knowledge) ->
        let content =
              Prelude.Text.concatMapSep
                ""
                Data.KnowledgeExample
                ( \(ke : Data.KnowledgeExample) ->
                    knowledge_level ke.level ke.name
                )

        in  ''
            <li class="knowledge">
              <h2>${knowledge.name}</h2>
              <ul class="examples">${content knowledge.values}</ul>
            </li>
            ''

let education =
      \(edu : Data.Education) ->
        let highlights =
              Prelude.Text.concatMap
                Text
                (\(x : Text) -> "<li>${x}</li>")
                edu.highlights

        in  ''
            <li>
              <h2>${edu.title}</h2>
              <aside>${period edu.period}</aside>
              <h3>${edu.from}</h3>
              <ul class="highlights">
                ${highlights}
              </ul>
            </li>
            ''

in  { social_account =
        \(account : ContactAccount) ->
          ''
          <li>
            <span class="site">${account.site}</span>
            <a class="username" href="${account.link}">${account.username}</a>
          </li>
          ''
    , month
    , period
    , job
    , project
    , knowledge
    , education
    }
