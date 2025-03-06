using System.IO;
using System.Linq;
using Resume;

namespace Program;

public class ResumeWriter : IResumeVisitor
{
    private readonly Capital.Data _capital;
    private readonly HtmlStreamWriter _writer;

    private Data? _data = null;

    private Capital.Job? _currentJob = null;
    private Capital.JobPosition? _currentJobPosition = null;

    private readonly string[] _stylesheets;
    private readonly string? _defences;

    public ResumeWriter(Capital.Data data, HtmlStreamWriter writer, string[] stylesheets, string? defences)
    {
        _capital = data;
        _writer = writer;

        _stylesheets = stylesheets;
        _defences = defences;
    }

    public void Visit(Data element)
    {
        _data = element;

        _writer.Write("<!DOCTYPE html>");
        _writer.Open("html");

        _writer.Open("head");
        foreach (var stylesheet in _stylesheets)
        {
            _writer.OpenClose("link", new() {
                { "rel", "stylesheet"},
                { "href", stylesheet },
            });
        }
        _writer.Open("title");
        _writer.Write("resume");
        _writer.Close("title");
        _writer.Close("head");

        _writer.Open("body");
        _writer.Open("article");

        _writer.Open("address");
        _writer.Open("p");
        _writer.Write(_capital.Name);
        _writer.Close("p");

        _writer.Open("a", new() {
            { "href", $"mailto:{_capital.Email}" },
        });
        _writer.Write(_capital.Email);
        _writer.Close("a");

        _writer.Open("span", new() {
            { "class", "location" },
        });
        _writer.Write(_capital.Location);
        _writer.Close("span");

        _writer.Open("ul", new() {
            { "class", "accounts" },
        });
        foreach (var account in _capital.Accounts)
        {
            _writer.Open("li");

            _writer.Open("a", new() {
                { "class", account.Site },
                { "href", account.Link },
            });
            _writer.Write(account.Site);
            _writer.Close("a");

            _writer.Close("li");
        }
        _writer.Close("ul");

        _writer.Close("address");

        if (_defences != null)
        {
            _writer.Open("section", new() {
                { "id", "defence" },
            });

            _writer.Write(_defences);

            _writer.Close("section");
        }

        _writer.Open("section", new() {
            { "id", "jobs" },
        });
        _writer.Open("header");
        _writer.Write("Employment");
        _writer.Close("header");

        _writer.Open("ol");
        foreach (var job in element.Jobs)
        {
            job.Accept(this);
        }
        _writer.Close("ol");

        _writer.Close("section"); // jobs

        _writer.Open("section", new() {
            { "id", "projects" },
        });
        _writer.Open("header");
        _writer.Write("Projects");
        _writer.Close("header");

        _writer.Open("ol");
        foreach (var project in element.Projects)
        {
            _writer.Open("li");
            project.Accept(this);
            _writer.Close("li");
        }
        _writer.Close("ol");
        _writer.Close("section"); // projects

        _writer.Open("section", new() {
            { "id", "certifications" },
        });
        _writer.Open("header");
        _writer.Write("Certifications");
        _writer.Close("header");

        _writer.Open("ul");
        foreach (var certification in element.Certifications)
        {
            _writer.Open("li");
            certification.Accept(this);
            _writer.Close("li");
        }
        _writer.Close("ul");

        _writer.Close("section"); // certifications

        _writer.Open("section");
        _writer.Open("header");
        _writer.Write("Degrees");
        _writer.Close("header");

        _writer.Open("ol");
        foreach (var degree in element.Degrees)
        {
            _writer.Open("li");
            degree.Accept(this);
            _writer.Close("li");
        }
        _writer.Close("ol");

        _writer.Close("section"); // degrees

        _writer.Close("article");
        _writer.Close("body");

        _writer.Close("html");
    }

    public void Visit(Job filter)
    {
        var job = _capital.Jobs.First(job => job.Company == filter.Company);

        _currentJob = job;
        if (filter.Positions.Length > 0)
        {
            foreach (var positionFilter in filter.Positions)
            {
                _writer.Open("li");
                positionFilter.Accept(this);
                _writer.Close("li");
            }
        }
        else
        {
            foreach (var position in job.Positions)
            {
                var positionFilter = new JobPosition()
                {
                    Title = position.Title,
                };

                _writer.Open("li");
                positionFilter.Accept(this);
                _writer.Close("li");
            }
        }
        _currentJob = null;
    }

    public void Visit(JobPosition filter)
    {
        var job = _currentJob!;

        var position = job.Positions.First(position => position.Title == filter.Title);

        _currentJobPosition = position;

        _writer.Open("section", new() {
            { "class", "job" },
        });

        _writer.Open("header", new() {
            { "class", "position" },
        });
        _writer.Write(position.Title);
        _writer.Close("header");

        _writer.Open("header", new() {
            { "class", "company" },
        });
        _writer.Write(job.Company);
        _writer.Close("header");

        _writer.Open("section", new()
        {
            { "class", "period" },
        });

        _writer.Open("time", new() {
            { "datetime", position.Start.ToString("yyyy-MM-dd")},
        });
        _writer.Write(position.Start.ToString("MMM yyyy"));
        _writer.Close("time");

        _writer.Open("span");
        _writer.Write("-");
        _writer.Close("span");

        if (position.End.HasValue)
        {
            _writer.Open("time", new() {
                { "datetime", position.End.Value.ToString("yyyy-MM-dd")},
            });
            _writer.Write(position.End.Value.ToString("MMM yyyy"));
            _writer.Close("time");
        }

        _writer.Close("section"); // period

        if (filter.Skills.Length > 0)
        {
            _writer.Open("ul", new()
            {
                { "class", "skills"}
            });

            foreach (var skillIndex in filter.Skills)
            {
                _writer.Open("li");
                var skill = position.Skills[skillIndex - 1];
                _writer.Write(skill);
                _writer.Close("li");
            }

            _writer.Close("ul");
        }

        if (filter.Quotes.Length > 0)
        {
            _writer.Open("ul", new()
            {
                { "class", "quote"}
            });

            foreach (var endorsementFilter in filter.Quotes)
            {
                _writer.Open("li");
                endorsementFilter.Accept(this);
                _writer.Close("li");
            }

            _writer.Close("ul");
        }

        if (filter.Knowledge)
        {
            var positionKnowledge = _data!.Knowledge
                .Where(knowledge => position.Knowledge.High.Contains(knowledge)
                    || position.Knowledge.Medium.Contains(knowledge)
                    || position.Knowledge.Low.Contains(knowledge));

            if (positionKnowledge.Any())
            {
                _writer.Open("ul", new() {
                    { "class", "knowledge"}
                });

                foreach (var knowledge in positionKnowledge)
                {
                    _writer.Open("li");
                    _writer.Write(knowledge);
                    _writer.Close("li");
                }

                _writer.Close("ul");
            }
        }

        _writer.Close("section");

        _currentJobPosition = null;
    }

    public void Visit(Quote filter)
    {
        var endorsement = _currentJobPosition!.Quotes.First(endorsement => endorsement.Name == filter.Name);

        _writer.Open("section", new()
        {
            { "class", "endorsement" },
        });

        _writer.Open("q");
        _writer.Write(endorsement.Quote);
        _writer.Close("q");

        _writer.Open("span", new()
        {
            { "class", "name" }
        });
        _writer.Write(endorsement.Name);
        _writer.Close("span");

        _writer.Open("span", new()
        {
            { "class", "position" }
        });
        _writer.Write(endorsement.Position);
        _writer.Close("span");

        _writer.Open("span", new()
        {
            { "class", "relation" }
        });
        _writer.Write(endorsement.Relation);
        _writer.Close("span");

        _writer.Close("section");
    }

    public void Visit(Project filter)
    {
        var project = _capital.Projects.First(project => project.Title == filter.Title);

        _writer.Open("section", new()
        {
            { "class", "project" }
        });

        _writer.Open("header");
        _writer.Write(project.Title);
        _writer.Close("header");

        _writer.Open("aside");
        if (project.Link != null)
        {
            _writer.Open("a", new() {
                { "href", project.Link },
            });
            _writer.Write("(link)");
            _writer.Close("a");
        }
        if (project.Repo != null)
        {
            _writer.Open("a", new() {
                { "href", project.Repo },
            });
            _writer.Write("(repo)");
            _writer.Close("a");
        }
        _writer.Close("aside");

        _writer.Open("p");
        _writer.Write(project.Purpose);
        _writer.Close("p");

        if (filter.Skills.Length > 0)
        {
            _writer.Open("ul", new()
            {
                { "class", "skills"},
            });

            foreach (var skillIndex in filter.Skills)
            {
                var skill = project.Skills[skillIndex - 1];

                _writer.Open("li");
                _writer.Write(skill);
                _writer.Close("li");
            }

            _writer.Close("ul");
        }

        if (filter.Knowledge)
        {
            var projectKnowledge = _data!.Knowledge
                .Where(knowledge => project.Knowledge.High.Contains(knowledge)
                    || project.Knowledge.Medium.Contains(knowledge)
                    || project.Knowledge.Low.Contains(knowledge));

            if (projectKnowledge.Any())
            {
                _writer.Open("ul", new()
                {
                    { "class", "knowledge"}
                });

                foreach (var knowledge in projectKnowledge)
                {
                    _writer.Open("li");
                    _writer.Write(knowledge);
                    _writer.Close("li");
                }

                _writer.Close("ul");
            }
        }

        _writer.Close("section");
    }

    public void Visit(Degree filter)
    {
        var degree = _capital.Degrees.First(degree => degree.Title == filter.Title);

        _writer.Open("section", new() {
            { "class", "degree" },
        });

        _writer.Open("header");
        _writer.Write(degree.Title);
        _writer.Close("header");

        _writer.Open("section", new() {
            { "class", "period" },
        });

        _writer.Open("time", new() {
            { "datetime", degree.Start.ToString("yyyy-MM")},
        });
        _writer.Write(degree.Start.ToString("MMM yyyy"));
        _writer.Close("time");

        _writer.Open("span");
        _writer.Write("-");
        _writer.Close("span");

        _writer.Open("time", new() {
            { "datetime", degree.End.ToString("yyyy-MM")},
        });
        _writer.Write(degree.End.ToString("MMM yyyy"));
        _writer.Close("time");

        _writer.Close("section"); // period

        _writer.Open("span", new() {
            { "class", "faculty" },
        });
        _writer.Write(degree.Faculty);
        _writer.Close("span");

        _writer.Open("span", new() {
            { "class", "institution" },
        });
        _writer.Write(degree.University);
        _writer.Close("span");

        _writer.Close("section");
    }

    public void Visit(Certification filter)
    {
        var certification = _capital.Certifications.First(cert => cert.Name == filter.Name);

        _writer.Open("section", new() {
            { "class", "certification" },
        });

        _writer.Open("header");
        _writer.Write(certification.Name);
        _writer.Close("header");

        if (certification.Url != null)
        {
            _writer.Open("aside");
            _writer.Open("a", new() {
                { "href", certification.Url}
            });
            _writer.Write("(verify)");
            _writer.Close("a");
            _writer.Close("aside");
        }

        _writer.Open("span", new() {
            { "class", "institution" },
        });
        _writer.Write(certification.Organization);
        _writer.Close("span");

        if (certification.Start.HasValue || certification.End.HasValue)
        {
            _writer.Open("section", new() {
                { "class", "period" },
            });

            if (certification.Start.HasValue)
            {
                _writer.Open("time", new() {
                    { "datetime", certification.Start.Value.ToString("yyyy-MM")},
                });
                _writer.Write(certification.Start.Value.ToString("MMM yyyy"));
                _writer.Close("time");
            }

            _writer.Open("span");
            _writer.Write("-");
            _writer.Close("span");

            if (certification.End.HasValue)
            {
                _writer.Open("time", new() {
                { "datetime", certification.End.Value.ToString("yyyy-MM")},
            });
                _writer.Write(certification.End.Value.ToString("MMM yyyy"));
                _writer.Close("time");
            }

            _writer.Close("section"); // period
        }

        _writer.Close("section");
    }
}