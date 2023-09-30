using System;
using System.IO;
using System.Linq;
using System.Collections.Generic;
using System.Threading.Tasks;
using Shake;
using Shake.FileSystem;
using System.Diagnostics;


namespace Resume
{
    public class Program
    {
        public static async Task Main(string[] args)
        {
            var working_directory = new DirectoryPath(Directory.GetCurrentDirectory());

            var file_system = new DefaultFileSystem(working_directory);
            var rules = new List<IRule<FilePath>>
            {
                new HtmlRule(file_system),
                new SassRule(file_system),
                new SourceFileRule(file_system),
            };

            var rule_set = new ListRuleSet<FilePath>(rules);
            var build = new DefaultBuildSystem<FilePath>(rule_set);

            await build.Want(new[]
            {
                new FilePath("dist/cover.html"),
                new FilePath("dist/cover.css"),
                new FilePath("dist/resume.html"),
                new FilePath("dist/resume.css"),
            });
        }
    }

    public class SassRule : IRule<FilePath>
    {
        private readonly IFileSystem _file_system;

        public SassRule(IFileSystem file_system)
        {
            _file_system = file_system;
        }

        public bool IsFor(FilePath resource)
        {
            return resource.Extension.Equals("css");
        }

        public async Task Build(IBuildSystem<FilePath>.IBuilder builder)
        {
            var source = new FilePathBuilder(builder.Resource);
            source.Directory.Up();
            source.Extension = "scss";

            await builder.Need(source.Path);

            var sass = new Process();
            sass.StartInfo.FileName = "rsass";
            sass.StartInfo.ArgumentList.Add(source.Path.ToString());
            sass.StartInfo.RedirectStandardOutput = true;
            sass.Start();

            await sass.WaitForExitAsync();

            using (var output = sass.StandardOutput)
            using (var file = await _file_system.SetText(builder.Resource))
            {
                var content = await output.ReadToEndAsync();
                await file.WriteAsync(content);
            }
        }
    }

    public class HtmlRule : IRule<FilePath>
    {
        private readonly IFileSystem _file_system;

        public HtmlRule(IFileSystem file_system)
        {
            _file_system = file_system;
        }

        public bool IsFor(FilePath resource)
        {
            return resource.Extension.Equals("html");
        }

        public async Task Build(IBuildSystem<FilePath>.IBuilder builder)
        {
            var source = new FilePathBuilder(builder.Resource);
            source.Directory.Up();
            source.Extension = "dhall";

            await builder.Need(source.Path);

            var file_dependencies = await GetFileDependencies(source.Path).ToArrayAsync();
            await builder.Need(file_dependencies);

            using (var output = await _file_system.SetText(builder.Resource))
            {
                await output.WriteAsync("");
            }

            var dhall = new Process();
            dhall.StartInfo.FileName = "dhall";
            dhall.StartInfo.ArgumentList.Add("text");
            dhall.StartInfo.ArgumentList.Add("--file");
            dhall.StartInfo.ArgumentList.Add(source.Path.ToString());
            dhall.StartInfo.ArgumentList.Add("--output");
            dhall.StartInfo.ArgumentList.Add(builder.Resource.ToString());
            dhall.Start();

            await dhall.WaitForExitAsync();
        }

        async IAsyncEnumerable<FilePath> GetFileDependencies(FilePath file_path)
        {
            var dhall = new Process();
            dhall.StartInfo.FileName = "dhall";
            dhall.StartInfo.ArgumentList.Add("resolve");
            dhall.StartInfo.ArgumentList.Add("--transitive-dependencies");
            dhall.StartInfo.ArgumentList.Add("--file");
            dhall.StartInfo.ArgumentList.Add(file_path.ToString());
            dhall.StartInfo.RedirectStandardOutput = true;
            dhall.Start();

            await dhall.WaitForExitAsync();

            using (var output = dhall.StandardOutput)
            {
                while (!output.EndOfStream)
                {
                    var line = await output.ReadLineAsync();
                    if (line != null && line.StartsWith("."))
                    {
                        yield return new FilePath(line);
                    }
                }
            }
        }
    }
}
