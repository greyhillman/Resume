using System;
using System.IO;

public class IndentTextWriter
{
    private readonly StreamWriter _writer;

    private int _indentLevel = 0;
    private readonly int _spacesPerIndent;

    public IndentTextWriter(StreamWriter writer, int spacesPerIndent)
    {
        _writer = writer;
        _spacesPerIndent = spacesPerIndent;
    }

    public void Indent()
    {
        _indentLevel += _spacesPerIndent;
    }

    public void Dedent()
    {
        _indentLevel = int.Max(_indentLevel - _spacesPerIndent, 0);
    }

    public IDisposable UseIndent()
    {
        var section = new IndentSection(this);
        Indent();

        return section;
    }

    public void WriteLine(string text)
    {
        var spaces = new string(' ', _indentLevel);
        _writer.Write(spaces);

        _writer.WriteLine(text);
    }

    public void WriteLine()
    {
        _writer.WriteLine();
    }

    private class IndentSection : IDisposable
    {
        private readonly IndentTextWriter _parent;

        public IndentSection(IndentTextWriter parent)
        {
            _parent = parent;
        }

        public void Dispose()
        {
            _parent.Dedent();
        }
    }
}