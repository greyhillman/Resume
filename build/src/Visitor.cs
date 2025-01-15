namespace Common;

public interface IVisitor<T> where T : IAcceptor<T>
{
    void Visit(T element);
}

public interface IAcceptor<T> where T : IAcceptor<T>
{
    void Accept(IVisitor<T> visitor);
}