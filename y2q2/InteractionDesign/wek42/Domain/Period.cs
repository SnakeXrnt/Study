using System;

namespace Week3
{
    public record Period(int Year, int Semester)
    {
        public override string ToString() => $"{Year}-{(Semester==1? "I":"II")}";
    }

    public enum InternshipCategory { Research, Minor, Engineering }
}