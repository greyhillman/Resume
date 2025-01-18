using System.Collections.Generic;
using System.Formats.Tar;
using System.IO;

namespace Program;

public class HtmlStreamWriter
{
    private readonly StreamWriter _writer;

    public HtmlStreamWriter(StreamWriter writer)
    {
        _writer = writer;
    }

    public void Open(string element, Dictionary<string, string>? attributes = null)
    {
        _writer.Write($"<{element}");

        if (attributes != null)
        {
            _writer.WriteLine();

            foreach (var entry in attributes)
            {
                if (string.IsNullOrEmpty(entry.Value))
                {
                    // Like "<script defer>" or "<button disabled>"
                    _writer.WriteLine($"{entry.Key}");
                }
                else
                {
                    _writer.WriteLine($"{entry.Key}=\"{entry.Value}\"");
                }
            }
        }

        _writer.WriteLine(">");
    }

    public void OpenClose(string element, Dictionary<string, string>? attributes = null)
    {
        _writer.Write($"<{element}");

        if (attributes != null)
        {
            _writer.WriteLine();

            foreach (var entry in attributes)
            {
                _writer.WriteLine($"{entry.Key}=\"{entry.Value}\"");
            }
        }

        _writer.WriteLine("/>");
    }

    public void Write(string value)
    {
        _writer.WriteLine(value);
    }

    public void Close(string element)
    {
        _writer.WriteLine($"</{element}>");
    }
}