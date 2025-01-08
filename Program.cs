using System.Threading.Tasks;
using System.CommandLine;
using System.IO;
using Tomlet;
using System;
using Tomlet.Models;
using Tomlet.Exceptions;
using System.Linq;


namespace Program
{
    public class Program
    {
        public static async Task<int> Main(string[] args)
        {
            var rootCommand = new RootCommand("Generate resume files");

            rootCommand.SetHandler(async () =>
            {
                await WriteCapital();
                await WriteResume();
            });

            var capitalCommand = new Command("capital", "Build capital files");
            capitalCommand.SetHandler(WriteCapital);

            var resumeCommand = new Command("resume", "Build resume files");
            resumeCommand.SetHandler(WriteResume);

            return await rootCommand.InvokeAsync(args);
        }

        static async Task WriteCapital()
        {
            using (var file = File.OpenText("./src/capital.toml"))
            {
                var content = await file.ReadToEndAsync();

                var capital = TomletMain.To<Capital.Data>(content);

                using (var writer = new StreamWriter("./dist/capital.html"))
                {
                    var htmlWriter = new HtmlStreamWriter(writer);
                    var visitor = new CapitalWriter(htmlWriter);

                    capital.Accept(visitor);

                    writer.Flush();
                }
            }
        }

        static async Task WriteResume()
        {
            using (var resumeFile = File.OpenText("./src/resume.toml"))
            using (var capitalFile = File.OpenText("./src/capital.toml"))
            {
                var resumeContent = await resumeFile.ReadToEndAsync();
                var capitalContent = await capitalFile.ReadToEndAsync();

                var resume = TomletMain.To<Resume.Data>(resumeContent);
                var capital = TomletMain.To<Capital.Data>(capitalContent);

                using (var writer = new StreamWriter("./dist/resume.html"))
                {
                    var htmlWriter = new HtmlStreamWriter(writer);
                    var visitor = new ResumeWriter(capital, htmlWriter);

                    resume.Accept(visitor);

                    writer.Flush();
                }
            }
        }
    }
}
