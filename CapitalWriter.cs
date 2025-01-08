using System.IO;
using System.Linq;
using Capital;

namespace Program;

public class CapitalWriter : ICapitalVisitor
{
    private readonly HtmlStreamWriter _writer;

    public CapitalWriter(HtmlStreamWriter writer)
    {
        _writer = writer;
    }

    public void Visit(Data element)
    {
        _writer.Write("<!DOCTYPE html>");
        _writer.Open("html");

        _writer.Open("head");

        _writer.OpenClose("link", new() {
            { "rel", "stylesheet"},
            { "href", "../src/reset.css" },
        });
        _writer.OpenClose("link", new() {
            { "rel", "stylesheet"},
            { "href", "../src/capital.css" },
        });
        _writer.OpenClose("meta", new() {
            { "charset", "utf-8" },
        });
        _writer.OpenClose("meta", new() {
            { "name", "viewport" },
            { "content", "width=device-width, height-device-height, intial-scale=1"},
        });

        _writer.Open("title");
        _writer.Write("Human Capital");
        _writer.Close("title");

        _writer.Close("head");

        _writer.Open("body");
        _writer.Open("article");

        _writer.Open("header");
        _writer.Write("Human Capital");
        _writer.Close("header");

        _writer.Open("section", new() {
            { "id", "experience" }
        });

        _writer.Open("header");
        _writer.Write("Experience");
        _writer.Close("header");

        _writer.Open("section", new() {
            { "id", "jobs" },
        });
        _writer.Open("header");
        _writer.Write("Jobs");
        _writer.Close("header");

        _writer.Open("ol");
        foreach (var job in element.Jobs)
        {
            _writer.Open("li");
            job.Accept(this);
            _writer.Close("li");
        }
        _writer.Close("ol");

        _writer.Close("section");

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
        _writer.Close("section");

        _writer.Close("section");


        _writer.Open("section", new() {
            { "id", "education" },
        });

        _writer.Open("section", new() {
            { "id", "degrees" },
        });
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

        _writer.Open("section", new() {
            { "id", "scholarships" },
        });
        _writer.Open("header");
        _writer.Write("Scholarships");
        _writer.Close("header");

        _writer.Open("ul");
        foreach (var scholarship in element.Scholarships)
        {
            _writer.Open("li");
            scholarship.Accept(this);
            _writer.Close("li");
        }
        _writer.Close("ul");

        _writer.Close("section"); // scholarships

        _writer.Close("section"); // education
        _writer.Close("article");
        _writer.Close("body");

        _writer.Close("html");
    }

    public void Visit(Account element)
    {
        throw new System.NotImplementedException();
    }

    public void Visit(Job job)
    {
        _writer.Open("section", new()
        {
            { "class", "job"}
        });

        _writer.Open("header");
        _writer.Write(job.Company);
        _writer.Close("header");

        _writer.Open("ol", new()
        {
            { "class", "position"}
        });
        foreach (var position in job.Positions)
        {
            _writer.Open("li");
            position.Accept(this);
            _writer.Close("li");
        }
        _writer.Close("ol");

        _writer.Close("section");
    }

    public void Visit(Capital.JobPosition position)
    {
        _writer.Open("section", new()
        {
            { "class", "position" },
        });

        _writer.Open("header");
        _writer.Write(position.Title);
        _writer.Close("header");

        _writer.Open("section", new()
        {
            { "class", "period" },
        });

        _writer.Open("time", new() {
            { "datetime", position.Start.ToString("yyyy-MM-dd")}
        });
        _writer.Write(position.Start.ToString("MMM yyyy"));
        _writer.Close("time");

        _writer.Open("span");
        _writer.Write("-");
        _writer.Close("span");

        if (position.End.HasValue)
        {
            _writer.Open("time", new() {
                { "datetime", position.End.Value.ToString("yyyy-MM-dd")}
            });
            _writer.Write(position.End.Value.ToString("MMM yyyy"));
            _writer.Close("time");
        }

        _writer.Close("section"); // period

        if (position.Skills.Length > 0)
        {
            _writer.Open("section", new() {
                { "class", "skills"}
            });

            _writer.Open("header");
            _writer.Write("Skills");
            _writer.Close("header");

            _writer.Open("ul", new()
            {
                { "class", "skills" },
            });
            foreach (var skill in position.Skills)
            {
                _writer.Open("li");
                _writer.Write(skill);
                _writer.Close("li");
            }
            _writer.Close("ul");

            _writer.Close("section");
        }

        position.Knowledge.Accept(this);

        if (position.Endorsements.Length > 0)
        {
            _writer.Open("section", new() {
                { "class", "endorsements"}
            });

            _writer.Open("header");
            _writer.Write("Endorsements");
            _writer.Close("header");

            _writer.Open("ul");
            foreach (var endorsement in position.Endorsements)
            {
                _writer.Open("li");
                endorsement.Accept(this);
                _writer.Close("li");
            }
            _writer.Close("ul");

            _writer.Close("section");
        }

        _writer.Close("section");
    }

    public void Visit(JobEndorsement endorsement)
    {
        _writer.Open("section", new() {
            { "class", "endorsement" }
        });

        _writer.Open("q");
        _writer.Write(endorsement.Quote);
        _writer.Close("q");

        _writer.Open("span", new() {
            { "class", "name" },
        });
        _writer.Write(endorsement.Name);
        _writer.Close("span");

        _writer.Open("span", new() {
            { "class", "position"},
        });
        _writer.Write(endorsement.Position);
        _writer.Close("span");

        _writer.Open("span", new() {
            { "class", "relation" },
        });
        _writer.Write(endorsement.Relation);
        _writer.Close("span");

        _writer.Close("section");
    }

    public void Visit(KnowledgeUsage element)
    {
        if (element.High.Length == 0
            && element.Medium.Length == 0
            && element.Low.Length == 0)
        {
            return;
        }

        _writer.Open("section", new() {
            { "class", "knowledge" }
        });
        _writer.Open("header");
        _writer.Write("Knowledge");
        _writer.Close("header");

        _writer.Open("ul", new()
        {
            { "class", "knowledge" }
        });
        foreach (var knowledge in element.High)
        {
            _writer.Open("li", new() {
                { "class", "high" },
                { "title", "Highly used"},
            });
            _writer.Write(knowledge);
            _writer.Close("li");
        }
        foreach (var knowledge in element.Medium)
        {
            _writer.Open("li", new() {
                { "class", "medium" },
                { "title", "Regularly used"},
            });
            _writer.Write(knowledge);
            _writer.Close("li");
        }
        foreach (var knowledge in element.Low)
        {
            _writer.Open("li", new() {
                { "class", "low" },
                { "title", "Rarely used"},
            });
            _writer.Write(knowledge);
            _writer.Close("li");
        }

        _writer.Close("ul");

        _writer.Close("section");
    }

    public void Visit(Project project)
    {
        _writer.Open("section", new() {
            { "class", "project" },
        });

        _writer.Open("header");
        _writer.Write(project.Title);

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
        _writer.Close("header");

        _writer.Open("p");
        _writer.Write(project.Purpose);
        _writer.Close("p");

        if (project.Skills.Length > 0)
        {
            _writer.Open("section", new() {
                { "class", "skills" },
            });
            _writer.Open("header");
            _writer.Write("Skills");
            _writer.Close("header");

            _writer.Open("ul", new() {
                { "class", "skills" },
            });
            foreach (var skill in project.Skills)
            {
                _writer.Open("li");
                _writer.Write(skill);
                _writer.Close("li");
            }
            _writer.Close("ul");

            _writer.Close("section");
        }

        project.Knowledge.Accept(this);

        _writer.Close("section");
    }

    public void Visit(Degree degree)
    {
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

        _writer.Open("section", new() {
            { "class", "skills" },
        });
        _writer.Open("header");
        _writer.Write("Skills");
        _writer.Close("header");

        _writer.Open("ul", new() {
            { "class", "skills" }
        });
        foreach (var skill in degree.Skills)
        {
            _writer.Open("li");
            _writer.Write(skill);
            _writer.Close("li");
        }
        _writer.Close("ul");

        _writer.Close("section"); // skills

        _writer.Close("section");
    }

    public void Visit(Certification certification)
    {
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

        if (certification.Start.HasValue)
        {
            _writer.Open("section", new()
            {
                { "class", "period" },
            });

            _writer.Open("span");
            _writer.Write("Valid");
            _writer.Close("span");

            _writer.Open("time", new() {
                { "datetime", certification.Start.Value.ToString("yyyy-MM")},
            });
            _writer.Write(certification.Start.Value.ToString("MMM yyyy"));
            _writer.Close("time");

            _writer.Open("span");
            _writer.Write("-");
            _writer.Close("span");

            _writer.Open("time", new() {
                { "datetime", certification.End.Value.ToString("yyyy-MM")},
            });
            _writer.Write(certification.End.Value.ToString("MMM yyyy"));
            _writer.Close("time");

            _writer.Close("section");
        }

        _writer.Close("section");
    }

    public void Visit(Scholarship scholarship)
    {
        _writer.Open("section", new() {
            { "class", "scholarship" },
        });

        _writer.Open("header");
        _writer.Write(scholarship.Name);
        _writer.Close("header");

        _writer.Open("span", new() {
            { "class", "year" }
        });
        _writer.Write($"{scholarship.Year}");
        _writer.Close("span");

        _writer.Open("span", new() {
            { "class", "institution" }
        });
        _writer.Write(scholarship.Institution);
        _writer.Close("span");

        _writer.Open("span", new() {
            { "class", "amount" }
        });
        _writer.Write(scholarship.Amount.ToString("C0"));
        _writer.Close("span");

        _writer.Close("section");
    }
}