using Common;
using Tomlet.Attributes;

namespace Resume;

public interface IResumeVisitor
    : IVisitor<Data>
    , IVisitor<Job>
    , IVisitor<JobPosition>
    , IVisitor<Endorsement>
    , IVisitor<Project>
    , IVisitor<Degree>
    , IVisitor<Certification>
{ }

public class Data : IAcceptor<Data>
{
    [TomlProperty("knowledge")]
    public required string[] Knowledge { get; set; }

    [TomlProperty("jobs")]
    public required Job[] Jobs { get; set; }

    [TomlProperty("projects")]
    public Project[] Projects { get; set; } = [];

    [TomlProperty("degrees")]
    public Degree[] Degrees { get; set; } = [];

    [TomlProperty("certifications")]
    public Certification[] Certifications { get; set; } = [];

    public void Accept(IVisitor<Data> visitor)
    {
        visitor.Visit(this);
    }
}

public class Job : IAcceptor<Job>
{
    [TomlProperty("company")]
    public required string Company { get; set; }

    [TomlProperty("positions")]
    public JobPosition[] Positions { get; set; } = [];

    public void Accept(IVisitor<Job> visitor)
    {
        visitor.Visit(this);
    }
}

public class JobPosition : IAcceptor<JobPosition>
{
    [TomlProperty("title")]
    public required string Title { get; set; }

    [TomlProperty("skills")]
    public int[] Skills { get; set; } = [];

    [TomlProperty("knowledge")]
    public bool Knowledge { get; set; } = false;

    [TomlProperty("endorsements")]
    public Endorsement[] Endorsements { get; set; } = [];

    public void Accept(IVisitor<JobPosition> visitor)
    {
        visitor.Visit(this);
    }
}

public class Endorsement : IAcceptor<Endorsement>
{
    [TomlProperty("name")]
    public string Name { get; set; } = "";

    public void Accept(IVisitor<Endorsement> visitor)
    {
        visitor.Visit(this);
    }
}

public class Project : IAcceptor<Project>
{
    [TomlProperty("title")]
    public required string Title { get; set; }

    [TomlProperty("skills")]
    public int[] Skills { get; set; } = [];

    [TomlProperty("knowledge")]
    public bool Knowledge { get; set; } = false;

    public void Accept(IVisitor<Project> visitor)
    {
        visitor.Visit(this);
    }
}

public class Degree : IAcceptor<Degree>
{
    [TomlProperty("title")]
    public required string Title { get; set; }

    public void Accept(IVisitor<Degree> visitor)
    {
        visitor.Visit(this);
    }
}

public class Certification : IAcceptor<Certification>
{
    [TomlProperty("name")]
    public required string Name { get; set; }

    public void Accept(IVisitor<Certification> visitor)
    {
        visitor.Visit(this);
    }
}