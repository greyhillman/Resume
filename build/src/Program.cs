using System.Threading.Tasks;
using System.CommandLine;
using System.IO;
using Tomlet;
using build;
using Common;
using build.Rebuilders;
using build.Schedulers;
using System;
using System.Collections.Generic;
using System.Text;
using System.Security.Cryptography;


namespace Program;

public class Program
{
    public static async Task<int> Main(string[] args)
    {
        var store = new DictionaryStore<string, FileContent>();
        var tasks = new DictionaryMap<string, IBuildTask<string, FileContent>>();

        var traces = new DictionaryVerifyingTraceStore<string, FileContent>();
        var rebuilder = new VerifyingTraceRebuilder<string, FileContent>(traces, store);
        var build = new SuspendingScheduler<string, FileContent>(rebuilder, tasks, store);

        tasks.Add("capital.toml", new SourceTask("../src/capital.toml"));
        tasks.Add("resume.toml", new SourceTask("../src/resume.toml"));

        tasks.Add("capital.html", new CapitalTask());
        tasks.Add("resume.html", new ResumeTask());
        tasks.Add("reset.css", new CopyTask("../src/reset.css", "../dist/reset.css"));
        tasks.Add("resume.css", new CopyTask("../src/resume.css", "../dist/resume.css"));
        tasks.Add("capital.css", new CopyTask("../src/capital.css", "../dist/capital.css"));

        var rootCommand = new RootCommand("Generate resume files");

        rootCommand.SetHandler(async () =>
        {
            await Task.WhenAll([
                build.Build("capital.html"),
                build.Build("resume.html"),
            ]);
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
                                Console.WriteLine("{0} updated...");

                                var key = Path.GetRelativePath("../src", file);

                                store.Remove(key); // Recompute the required tasks
                            }
                        }

                        lastWriteTimes[file] = writeTime;
                    }

                    await Task.WhenAll([
                        build.Build("capital.html"),
                        build.Build("resume.html"),
                    ]);

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

public class CapitalTask : IBuildTask<string, FileContent>
{
    public async Task<FileContent> Execute(IBuildSystem<string, FileContent> system)
    {
        Console.WriteLine("Compiling capital...");

        var capitalPath = await system.Build("capital.toml");

        var resetStylesheet = await system.Build("reset.css");
        var capitalStylesheet = await system.Build("capital.css");

        var content = capitalPath.Content;
        var capital = TomletMain.To<Capital.Data>(content);

        using (var writer = new StreamWriter("../dist/capital.html"))
        {
            var htmlWriter = new HtmlStreamWriter(writer);
            var visitor = new CapitalWriter(htmlWriter, [
                resetStylesheet.Path,
                capitalStylesheet.Path,
            ]);

            capital.Accept(visitor);

            await writer.FlushAsync();
        }

        using (var reader = new StreamReader("../dist/capital.html", Encoding.UTF8))
        {
            var result = await reader.ReadToEndAsync();

            return new FileContent("../dist/capital.html", result);
        }
    }
}

public class ResumeTask : IBuildTask<string, FileContent>
{
    public async Task<FileContent> Execute(IBuildSystem<string, FileContent> system)
    {
        Console.WriteLine("Compiling resume...");

        var resumePath = await system.Build("resume.toml");
        var capitalPath = await system.Build("capital.toml");

        var resetStylesheet = await system.Build("reset.css");
        var resumeStylesheet = await system.Build("resume.css");

        var resumeContent = resumePath.Content;
        var capitalContent = capitalPath.Content;

        var resume = TomletMain.To<Resume.Data>(resumeContent);
        var capital = TomletMain.To<Capital.Data>(capitalContent);

        using (var writer = new StreamWriter("../dist/resume.html"))
        {
            var htmlWriter = new HtmlStreamWriter(writer);
            var visitor = new ResumeWriter(capital, htmlWriter, [
                resetStylesheet.Path,
                resumeStylesheet.Path,
            ]);

            resume.Accept(visitor);

            writer.Flush();
        }

        using (var reader = new StreamReader("../dist/resume.html"))
        {
            var content = await reader.ReadToEndAsync();

            return new FileContent("../dist/resume.html", content);
        }
    }
}

public class CopyTask : IBuildTask<string, FileContent>
{
    private readonly string _from;
    private readonly string _to;

    public CopyTask(string from, string to)
    {
        _from = from;
        _to = to;
    }

    public async Task<FileContent> Execute(IBuildSystem<string, FileContent> system)
    {
        Console.WriteLine("Copying file from {0} to {1}", _from, _to);

        File.Copy(_from, _to, overwrite: true);

        using (var reader = new StreamReader(_to))
        {
            var content = await reader.ReadToEndAsync();

            return new FileContent(Path.GetRelativePath("../dist", _to), content);
        }
    }
}

public class SourceTask : IBuildTask<string, FileContent>
{
    private readonly string _path;

    public SourceTask(string path)
    {
        _path = path;
    }

    public async Task<FileContent> Execute(IBuildSystem<string, FileContent> system)
    {
        Console.WriteLine("Getting source file contents: {0}", _path);

        using (var reader = new StreamReader(_path))
        {
            var content = await reader.ReadToEndAsync();

            return new FileContent(_path, content);
        }
    }
}