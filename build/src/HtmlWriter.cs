using System;
using System.Collections.Generic;
using System.Formats.Tar;
using System.IO;

namespace Program;

public class HtmlStreamWriter
{
    private readonly StreamWriter _writer;

    private int _indentLevel = 0;
    private readonly int _spacesPerIndent;

    public HtmlStreamWriter(StreamWriter writer, int spacesPerIndent)
    {
        _writer = writer;
        _spacesPerIndent = spacesPerIndent;
    }

    private void Indent()
    {
        _indentLevel += _spacesPerIndent;
    }

    private void Dedent()
    {
        _indentLevel -= _spacesPerIndent;
    }

    private void WriteIndent()
    {
        var spaces = new string(' ', _indentLevel);
        _writer.Write(spaces);
    }

    public void Open(string element, Dictionary<string, string>? attributes = null)
    {
        WriteIndent();
        _writer.Write($"<{element}");

        if (attributes != null)
        {
            if (attributes.Count > 2)
            {
                _writer.WriteLine();
                Indent();

                foreach (var entry in attributes)
                {
                    if (string.IsNullOrEmpty(entry.Value))
                    {
                        // Like "<script defer>" or "<button disabled>"
                        WriteIndent();
                        _writer.WriteLine($"{entry.Key}");
                    }
                    else
                    {
                        WriteIndent();
                        _writer.WriteLine($"{entry.Key}=\"{entry.Value}\"");
                    }
                }

                Dedent();
                WriteIndent();
            }
            else
            {
                foreach (var entry in attributes)
                {
                    _writer.Write(" ");

                    if (string.IsNullOrEmpty(entry.Value))
                    {
                        // Like "<script defer>" or "<button disabled>"
                        _writer.Write($"{entry.Key}");
                    }
                    else
                    {
                        _writer.Write($"{entry.Key}=\"{entry.Value}\"");
                    }
                }
            }
        }

        _writer.WriteLine(">");
        Indent();
    }

    public void OpenClose(string element, Dictionary<string, string>? attributes = null)
    {
        WriteIndent();
        _writer.Write($"<{element}");

        if (attributes != null)
        {
            if (attributes.Count > 2)
            {
                _writer.WriteLine();
                Indent();

                foreach (var entry in attributes)
                {
                    if (string.IsNullOrEmpty(entry.Value))
                    {
                        // Like "<script defer>" or "<button disabled>"
                        WriteIndent();
                        _writer.WriteLine($"{entry.Key}");
                    }
                    else
                    {
                        WriteIndent();
                        _writer.WriteLine($"{entry.Key}=\"{entry.Value}\"");
                    }
                }

                Dedent();
                WriteIndent();
            }
            else
            {
                foreach (var entry in attributes)
                {
                    _writer.Write(" ");

                    if (string.IsNullOrEmpty(entry.Value))
                    {
                        // Like "<script defer>" or "<button disabled>"
                        _writer.Write($"{entry.Key}");
                    }
                    else
                    {
                        _writer.Write($"{entry.Key}=\"{entry.Value}\"");
                    }
                }
            }
        }

        _writer.Write(" ");
        _writer.WriteLine("/>");
    }

    public void Write(string value)
    {
        foreach (var line in value.Split(Environment.NewLine))
        {
            WriteIndent();
            _writer.WriteLine(line);
        }
    }

    public void Close(string element)
    {
        Dedent();
        WriteIndent();
        _writer.WriteLine($"</{element}>");
    }
}