using System;

namespace Week3
{
    public class Student
    {
        public string StudentId { get; init; }
        public string FirstName { get; set; }   // changed to settable to allow updates
        public string LastName { get; set; }    // changed to settable to allow updates
        public Assignment? CurrentAssignment { get; set; }

        public Student(string id, string first, string last)
        {
            StudentId = id; FirstName = first; LastName = last;
        }

        public override string ToString() => $"{FirstName} {LastName} ({StudentId})";
    }
}