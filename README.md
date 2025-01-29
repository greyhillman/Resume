# Resume

A repo to

1. store resume info
2. to generate resumes for job applications

## How to make new Resume

1. Edit `src/resume.toml` to have the information from `src/capital.toml` for a new resume.
2. Run

```bash
dotnet run
```

3. Style the resume using `src/resume.css`
4. Run

```bash
dotnet run
```

5. Print the page in Firefox to a PDF.
6. Send Resume; create new commit.

## General Idea

In economics, a worker has what's called [Human Capital](https://www.investopedia.com/terms/h/humancapital.asp).
It's the combined

- knowledge,
- skills, and
- experience

the worker has acquired over time.
The more human capital a worker has, the more productive they are.

A resume typically has sections for

- employment
- certifications
- degrees
- projects
- quotes
- etc.

Those sections are merely sub-categories of human capital:

- Employment and projects would fall under experience
- Degrees and certifications would fall under knowledge
- Quotes would be used to back up skills

### Problems & Solutions

For each new job I apply for, I change my resume to best fit the job's description.

**Problem**: When I remove an item from my resume, I have the potential to forget the item in the future.

**Solution**: Keep all the information the resume could contain.

...which gives rise to...

**Problem**: I don't want my resume to turn into multiple pages; a one-page summary should suffice.

**Solution**: Separate all potential data from the resume.

Previously, I was using a Google Doc to hold and format my resume.
It was a pain in the ass to change things as the layout and styling was highly dependent on the content.
I'm sure there's ways around it, but I don't want to know more about Google Docs.

**Problem**: Google Doc's view is highly dependent on the content.

**Solution**: Separate content from view: HTML = content, CSS = styling

