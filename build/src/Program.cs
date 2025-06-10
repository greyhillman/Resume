using System.Threading.Tasks;
using System.CommandLine;
using System.IO;
using Tomlet;
using PolyBuild;
using Common;
using PolyBuild.Rebuilders;
using PolyBuild.Schedulers;
using System;
using System.Collections.Generic;
using System.Text;
using System.Security.Cryptography;
using Microsoft.Extensions.Logging;
using Microsoft.Extensions.Logging.Console;
using System.Runtime.CompilerServices;
using System.Collections.Map;


namespace Program;

public class Program
{
    public static async Task<int> Main(string[] args)
    {
        var loggerFactory = LoggerFactory.Create(builder =>
        {
            builder.AddSimpleConsole(options =>
            {
                options.SingleLine = true;
                options.ColorBehavior = LoggerColorBehavior.Disabled;
            });

            builder.AddFilter("PolyBuild.Rebuilders", LogLevel.Warning);
            builder.AddFilter("PolyBuild.Schedulers", LogLevel.Warning);
        });
        var store = new DictionaryStore<string, FileContent>();
        var tasks = new DictionaryMap<string, IBuildTask<string, FileContent>>();

        var traces = new DictionaryVerifyingTraceStore<string, FileContent>();
        var rebuilder = new VerifyingTraceRebuilder<string, FileContent>(loggerFactory, traces, store);
        var builder = new SuspendingScheduler<string, FileContent>(loggerFactory, rebuilder, tasks, store);

        tasks.Add("capital.toml", new SourceTask(loggerFactory, "../src/capital.toml"));
        tasks.Add("resume.toml", new SourceTask(loggerFactory, "../src/resume.toml"));
        tasks.Add("defence.md", new SourceTask(loggerFactory, "../src/defence.md"));

        tasks.Add("capital/index.html", new CapitalTask(loggerFactory));
        tasks.Add("capital/reset.css", new CopyTask(loggerFactory, "../src/reset.css", "../dist/capital/reset.css"));
        tasks.Add("capital/index.css", new CopyTask(loggerFactory, "../src/capital.css", "../dist/capital/index.css"));

        tasks.Add("resume/index.html", new ResumeTask(loggerFactory));
        tasks.Add("resume/reset.css", new CopyTask(loggerFactory, "../src/reset.css", "../dist/resume/reset.css"));
        tasks.Add("resume/index.css", new CopyTask(loggerFactory, "../src/resume.css", "../dist/resume/index.css"));

        tasks.Add("linkedin.txt", new LinkedInTask(loggerFactory));

        var rootCommand = new RootCommand("Generate resume files");

        rootCommand.SetHandler(async () =>
        {
            await builder.Build("capital/index.html");
            await builder.Build("resume/index.html");
            await builder.Build("linkedin.txt");
        });

        var watchCommand = new Command("watch", "Rebuild on file changes");
        watchCommand.SetHandler(async (context) =>
        {
            var token = context.GetCancellationToken();

            var lastWriteTimes = new Dictionary<string, DateTimeOffset>();

            try
            {
                while (!token.IsCancellationRequested)
                {
                    foreach (var file in Directory.GetFiles("../src"))
                    {
                        var writeTime = File.GetLastWriteTime(file);

                        if (lastWriteTimes.TryGetValue(file, out var lastWrite))
                        {
                            if (writeTime > lastWrite)
                            {
                                Console.WriteLine("{0} updated...", file);

                                var key = Path.GetRelativePath("../src", file);

                                store.Remove(key); // Recompute the required tasks
                            }
                        }

                        lastWriteTimes[file] = writeTime;
                    }

                    await builder.Build("capital/index.html");
                    await builder.Build("resume/index.html");

                    await Task.Delay(1000, token);
                }
            }
            catch (OperationCanceledException)
            {
                Console.WriteLine();
                Console.WriteLine("Command cancelled.");
            }
            finally
            {
                Console.WriteLine("Stopped.");
            }
        });

        rootCommand.AddCommand(watchCommand);

        return await rootCommand.InvokeAsync(args);
    }
}

public class FileContent : IHashable
{
    public string Path { get; }
    public string Content { get; }

    public FileContent(string path, string content)
    {
        Path = path;
        Content = content;
    }

    public string GetHash()
    {
        var message = Encoding.UTF8.GetBytes(Path + Content);

        var digest = MD5.HashData(message);

        return Convert.ToHexString(digest);
    }
}

public class LinkedInTask : IBuildTask<string, FileContent>
{
    private readonly ILogger _logger;

    public LinkedInTask(ILoggerFactory loggerFactory)
    {
        _logger = loggerFactory.CreateLogger<CapitalTask>();
    }

    public async Task<FileContent> Execute(IBuildSystem<string, FileContent> system)
    {
        var capitalPath = await system.Build("capital.toml");

        var content = capitalPath.Content;
        var capital = TomletMain.To<Capital.Data>(content);

        using (var writer = new StreamWriter("../dist/linkedin.txt"))
        {
            var indentWriter = new IndentTextWriter(writer, 4);
            var visitor = new LinkedInWriter(indentWriter);

            capital.Accept(visitor);

            await writer.FlushAsync();
        }

        using (var reader = new StreamReader("../dist/linkedin.txt", Encoding.UTF8))
        {
            var result = await reader.ReadToEndAsync();

            return new FileContent("../dist/linkedin.txt", result);
        }
    }
}

public class CapitalTask : IBuildTask<string, FileContent>
{
    private readonly ILogger _logger;

    public CapitalTask(ILoggerFactory loggerFactory)
    {
        _logger = loggerFactory.CreateLogger<CapitalTask>();
    }

    public async Task<FileContent> Execute(IBuildSystem<string, FileContent> system)
    {
        var capitalPath = await system.Build("capital.toml");

        var resetStylesheet = await system.Build("capital/reset.css");
        var capitalStylesheet = await system.Build("capital/index.css");

        var content = capitalPath.Content;
        var capital = TomletMain.To<Capital.Data>(content);

        using (var writer = new StreamWriter("../dist/capital/index.html"))
        {
            var htmlWriter = new HtmlStreamWriter(writer, spacesPerIndent: 4);
            var visitor = new CapitalWriter(htmlWriter, [
                Path.GetRelativePath("../dist/capital", resetStylesheet.Path),
                Path.GetRelativePath("../dist/capital", capitalStylesheet.Path),
            ]);

            capital.Accept(visitor);

            await writer.FlushAsync();
        }

        using (var reader = new StreamReader("../dist/capital/index.html", Encoding.UTF8))
        {
            var result = await reader.ReadToEndAsync();

            return new FileContent("../dist/capital/index.html", result);
        }
    }
}

public class ResumeTask : IBuildTask<string, FileContent>
{
    private readonly ILogger _logger;

    public ResumeTask(ILoggerFactory loggerFactory)
    {
        _logger = loggerFactory.CreateLogger<ResumeTask>();
    }

    public async Task<FileContent> Execute(IBuildSystem<string, FileContent> system)
    {
        var resumePath = await system.Build("resume.toml");
        var capitalPath = await system.Build("capital.toml");

        var resetStylesheet = await system.Build("resume/reset.css");
        var resumeStylesheet = await system.Build("resume/index.css");

        var resumeContent = resumePath.Content;
        var capitalContent = capitalPath.Content;

        var resume = TomletMain.To<Resume.Data>(resumeContent);
        var capital = TomletMain.To<Capital.Data>(capitalContent);

        FileContent? defenceFile = null;
        if (resume.IncludeDefences)
        {
            defenceFile = await system.Build("defence.md");
        }

        using (var writer = new StreamWriter("../dist/resume/index.html"))
        {
            var htmlWriter = new HtmlStreamWriter(writer, spacesPerIndent: 4);
            var visitor = new ResumeWriter(capital, htmlWriter, [
                Path.GetRelativePath("../dist/resume", resetStylesheet.Path),
                Path.GetRelativePath("../dist/resume", resumeStylesheet.Path),
            ], defenceFile?.Content);

            resume.Accept(visitor);

            writer.Flush();
        }

        using (var reader = new StreamReader("../dist/resume/index.html"))
        {
            var content = await reader.ReadToEndAsync();

            return new FileContent("../dist/resume/index.html", content);
        }
    }
}

public class CopyTask : IBuildTask<string, FileContent>
{
    private readonly ILogger _logger;

    private readonly string _from;
    private readonly string _to;

    public CopyTask(ILoggerFactory loggerFactory, string from, string to)
    {
        _logger = loggerFactory.CreateLogger<CopyTask>();

        _from = from;
        _to = to;
    }

    public async Task<FileContent> Execute(IBuildSystem<string, FileContent> system)
    {
        _logger.LogInformation("Copying file from {Source} to {Destination}", _from, _to);

        File.Copy(_from, _to, overwrite: true);

        using (var reader = new StreamReader(_to))
        {
            var content = await reader.ReadToEndAsync();

            return new FileContent(_to, content);
        }
    }
}

public class SourceTask : IBuildTask<string, FileContent>
{
    private readonly ILogger _logger;

    private readonly string _path;

    public SourceTask(ILoggerFactory loggerFactory, string path)
    {
        _logger = loggerFactory.CreateLogger<SourceTask>();

        _path = path;
    }

    public async Task<FileContent> Execute(IBuildSystem<string, FileContent> system)
    {
        _logger.LogInformation("Getting source file contents for {File}", _path);

        using (var reader = new StreamReader(_path))
        {
            var content = await reader.ReadToEndAsync();

            return new FileContent(_path, content);
        }
    }
}