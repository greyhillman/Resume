let data = ./src/resume.dhall

let date = "November 1st, 2021"

let position_title = "C# Software Developer"

let company = "Reliable Controls"

let content =
      ''
      <p>
        I am writing to ask about working at Reliable Controls as a C#
        Software Developer. I am interested in applying my knowledge and
        skills for building automation controls.
      </p>
      <p>
        My passion for learning is a valuable asset, especially combined with
        a strong work ethic. During my spare time, I have been learning
        Haskell and its various libraries. The techniques and experience from
        the functional programming world have carried over into my work. For
        example, at Helm Operations, I introduced
        <q>Property-based Testing</q>. It is basically a middle-point between
        unit testing and formal proofs, allowing the test to check hundreds or
        thousands of random cases to ensure software correctness and
        confidence. I introduced this new type of testing for a payroll-like
        system, knowing traditional unit tests would not perform well for that
        area.
      </p>
      <p>
        Because of my passion for learning, I like to work in new industries.
        My time working with UVic's Civil Engineering department was a great
        experience and an eye-opener for me. They had similar goals Reliable
        Controls has: reducing carbon impact and optimizing energy usage. It
        would be a great opportunity to work in that area again!
      </p>
      <p>I look forward to meeting you. Thank you for your time.</p>
      ''

in  ''
    <html>
        <head>
            <link href="./cover.css" rel="stylesheet" />
        </head>
        <body>
            <article>
                <header>
                    <address>
                        <span class="name">${data.contact.name}</span>
                        <span class="address">${data.contact.address}</span>
                        <a href="mailto:${data.contact.email}">${data.contact.email}</a>
                    </address>
                    <time>${date}</time>
                    <h1>RE: ${position_title}</h1>
                </header>
                <main>
                    <h2> Dear ${company},</h2>
                    ${content}
                </main>
                <footer>
                    Regards, <span class="name">${data.contact.name}</span>
                </footer>
            </article>
        </body>
    </html>
    ''
