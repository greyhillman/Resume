using System;
using System.IO;
using System.Threading.Tasks.Dataflow;
using Capital;

namespace Program;

public class LinkedInWriter : ICapitalVisitor
{
    private readonly IndentTextWriter _writer;

    public LinkedInWriter(IndentTextWriter writer)
    {
        _writer = writer;
    }

    public void Visit(Data data)
    {
        _writer.WriteLine("Experience");
        _writer.Indent();
        foreach (var job in data.Jobs)
        {
            job.Accept(this);
        }
        _writer.Dedent();

        _writer.WriteLine("Education");
        _writer.Indent();
        foreach (var degree in data.Degrees)
        {
            degree.Accept(this);
        }
        _writer.Dedent();

        _writer.WriteLine("Certifications");
        _writer.Indent();
        foreach (var certification in data.Certifications)
        {
            certification.Accept(this);
        }
        _writer.Dedent();

        _writer.WriteLine("Projects");
        _writer.Indent();
        foreach (var project in data.Projects)
        {
            project.Accept(this);
            _writer.WriteLine();
        }
        _writer.Dedent();
    }

    public void Visit(Account element)
    {
        throw new System.NotImplementedException();
    }

    public void Visit(Job job)
    {
        _writer.WriteLine(job.Company);
        _writer.Indent();

        foreach (var position in job.Positions)
        {
            position.Accept(this);
            _writer.WriteLine();
        }

        _writer.Dedent();
    }

    public void Visit(Capital.JobPosition position)
    {
        _writer.WriteLine(position.Title);

        _writer.WriteLine("Employment Type");
        using (_writer.UseIndent())
        {
            if (!string.IsNullOrWhiteSpace(position.Contract))
            {
                _writer.WriteLine(position.Contract);
            }
        }

        _writer.WriteLine("Start date");
        using (_writer.UseIndent())
        {
            _writer.WriteLine(position.Start.ToString("MMMM yyyy"));
        }

        if (position.End.HasValue)
        {
            _writer.WriteLine("End date");
            using (_writer.UseIndent())
            {
                _writer.WriteLine(position.End.Value.ToString("MMMM yyyy")); ;
            }
        }

        _writer.WriteLine("Location");
        using (_writer.UseIndent())
        {
            _writer.WriteLine(position.Location);
        }

        _writer.WriteLine("Description");
        using (_writer.UseIndent())
        {
            foreach (var skill in position.Skills)
            {
                _writer.WriteLine($"- {skill}");
            }
        }

        _writer.WriteLine("Skills");
        using (_writer.UseIndent())
        {
            foreach (var knowledge in position.Knowledge.High)
            {
                _writer.WriteLine($"- {knowledge}");
            }

            _writer.WriteLine();

            foreach (var knowledge in position.Knowledge.Medium)
            {
                _writer.WriteLine($"- {knowledge}");
            }

            _writer.WriteLine();

            foreach (var knowledge in position.Knowledge.Low)
            {
                _writer.WriteLine($"- {knowledge}");
            }
        }
    }

    public void Visit(JobQuote endorsement)
    {
        throw new NotImplementedException();
    }

    public void Visit(KnowledgeUsage element)
    {
        throw new NotImplementedException();
    }

    public void Visit(Project project)
    {
        _writer.WriteLine(project.Title);
        _writer.Indent();

        _writer.WriteLine("Description");
        using (_writer.UseIndent())
        {
            _writer.WriteLine($"Purpose: {project.Purpose}");
            _writer.WriteLine();

            foreach (var skill in project.Skills)
            {
                _writer.WriteLine($"- {skill}");
            }
        }

        _writer.WriteLine("Media");
        _writer.Indent();
        if (project.Link != null)
        {
            _writer.WriteLine($"- {project.Link}");
        }
        if (project.Repo != null)
        {
            _writer.WriteLine($"- {project.Repo}");
        }
        _writer.Dedent();

        _writer.WriteLine("Start date");
        using (_writer.UseIndent())
        {
            if (project.StartDate.HasValue)
            {
                _writer.WriteLine(project.StartDate.Value.ToString("MMMM yyyy"));
            }
        }

        _writer.WriteLine("End date");
        using (_writer.UseIndent())
        {
            if (project.EndDate.HasValue)
            {
                _writer.WriteLine(project.EndDate.Value.ToString("MMMM yyyy"));
            }
        }

        _writer.Dedent();
    }

    public void Visit(Degree degree)
    {
        _writer.WriteLine(degree.University);
        _writer.WriteLine(degree.Title);
        _writer.WriteLine(degree.Faculty);

        _writer.WriteLine(degree.Start.ToString("MMMM yyyy"));
        _writer.WriteLine(degree.End.ToString("MMMM yyyy"));
    }

    public void Visit(Certification certification)
    {
        _writer.WriteLine(certification.Name);
        _writer.WriteLine(certification.Organization);

        if (certification.Start.HasValue)
        {
            _writer.WriteLine($"{certification.Start.Value.Month} {certification.Start.Value.Year}");
        }
        if (certification.End.HasValue)
        {
            _writer.WriteLine($"{certification.End.Value.Month} {certification.End.Value.Year}");
        }

        if (certification.Url != null)
        {
            _writer.WriteLine(certification.Url);
        }
    }

    public void Visit(Scholarship scholarship)
    {
        throw new NotImplementedException();
    }
}