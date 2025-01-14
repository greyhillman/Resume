using System;
using Common;
using Tomlet.Attributes;

namespace Capital;

public interface ICapitalVisitor
    : IVisitor<Data>
    , IVisitor<Account>
    , IVisitor<Job>
    , IVisitor<JobPosition>
    , IVisitor<JobEndorsement>
    , IVisitor<KnowledgeUsage>
    , IVisitor<Project>
    , IVisitor<Degree>
    , IVisitor<Certification>
    , IVisitor<Scholarship>
{ }

public class Data : IAcceptor<Data>
{
    [TomlProperty("name")]
    public required string Name { get; set; }

    [TomlProperty("email")]
    public required string Email { get; set; }

    [TomlProperty("accounts")]
    public required Account[] Accounts { get; set; }

    [TomlProperty("jobs")]
    public required Job[] Jobs { get; set; }

    [TomlProperty("projects")]
    public required Project[] Projects { get; set; }

    [TomlProperty("degrees")]
    public required Degree[] Degrees { get; set; }

    [TomlProperty("certifications")]
    public Certification[] Certifications { get; set; } = [];

    [TomlProperty("scholarships")]
    public Scholarship[] Scholarships { get; set; } = [];

    public void Accept(IVisitor<Data> visitor)
    {
        visitor.Visit(this);
    }
}

public class Account : IAcceptor<Account>
{
    [TomlProperty("site")]
    public required string Site { get; set; }

    [TomlProperty("username")]
    public required string Username { get; set; }

    [TomlProperty("link")]
    public required string Link { get; set; }

    public void Accept(IVisitor<Account> visitor)
    {
        visitor.Visit(this);
    }
}

public class Job : IAcceptor<Job>
{
    [TomlProperty("company")]
    public required string Company { get; set; }

    [TomlProperty("positions")]
    public required JobPosition[] Positions { get; set; }

    public void Accept(IVisitor<Job> visitor)
    {
        visitor.Visit(this);
    }
}

public class JobPosition : IAcceptor<JobPosition>
{
    [TomlProperty("title")]
    public required string Title { get; set; }

    [TomlProperty("start")]
    public required DateTime Start { get; set; }

    [TomlProperty("end")]
    public DateTime? End { get; set; }

    [TomlProperty("skills")]
    public string[] Skills { get; set; } = [];

    [TomlProperty("endorsements")]
    public JobEndorsement[] Endorsements { get; set; } = [];

    [TomlProperty("knowledge")]
    public KnowledgeUsage Knowledge { get; set; } = new KnowledgeUsage();

    public void Accept(IVisitor<JobPosition> visitor)
    {
        visitor.Visit(this);
    }
}

public class JobEndorsement : IAcceptor<JobEndorsement>
{
    [TomlProperty("quote")]
    public required string Quote { get; set; }

    [TomlProperty("name")]
    public required string Name { get; set; }

    [TomlProperty("position")]
    public required string Position { get; set; }

    [TomlProperty("relation")]
    public required string Relation { get; set; }

    public void Accept(IVisitor<JobEndorsement> visitor)
    {
        visitor.Visit(this);
    }
}

public class KnowledgeUsage : IAcceptor<KnowledgeUsage>
{
    [TomlProperty("high")]
    public string[] High { get; set; } = [];

    [TomlProperty("medium")]
    public string[] Medium { get; set; } = [];

    [TomlProperty("low")]
    public string[] Low { get; set; } = [];

    public void Accept(IVisitor<KnowledgeUsage> visitor)
    {
        visitor.Visit(this);
    }
}

public class Project : IAcceptor<Project>
{
    [TomlProperty("title")]
    public required string Title { get; set; }

    [TomlProperty("link")]
    public string? Link { get; set; }

    [TomlProperty("repo")]
    public string? Repo { get; set; }

    [TomlProperty("purpose")]
    public required string Purpose { get; set; }

    [TomlProperty("skills")]
    public string[] Skills { get; set; } = [];

    [TomlProperty("knowledge")]
    public KnowledgeUsage Knowledge { get; set; } = new KnowledgeUsage();

    public void Accept(IVisitor<Project> visitor)
    {
        visitor.Visit(this);
    }
}

public class Degree : IAcceptor<Degree>
{
    [TomlProperty("title")]
    public required string Title { get; set; }

    [TomlProperty("faculty")]
    public required string Faculty { get; set; }

    [TomlProperty("university")]
    public required string University { get; set; }

    [TomlProperty("start")]
    public required DateTime Start { get; set; }

    [TomlProperty("end")]
    public required DateTime End { get; set; }

    [TomlProperty("skills")]
    public string[] Skills { get; set; } = [];

    public void Accept(IVisitor<Degree> visitor)
    {
        visitor.Visit(this);
    }
}

public class Certification : IAcceptor<Certification>
{
    [TomlProperty("name")]
    public required string Name { get; set; }

    [TomlProperty("organization")]
    public required string Organization { get; set; }

    [TomlProperty("valid_start")]
    public DateTime? Start { get; set; }

    [TomlProperty("valid_end")]
    public DateTime? End { get; set; }

    [TomlProperty("url")]
    public string? Url { get; set; }

    public void Accept(IVisitor<Certification> visitor)
    {
        visitor.Visit(this);
    }
}

public class Scholarship : IAcceptor<Scholarship>
{
    [TomlProperty("name")]
    public required string Name { get; set; }

    [TomlProperty("institution")]
    public required string Institution { get; set; }

    [TomlProperty("date")]
    public required int Year { get; set; }

    [TomlProperty("amount")]
    public required int Amount { get; set; }

    public void Accept(IVisitor<Scholarship> visitor)
    {
        visitor.Visit(this);
    }
}