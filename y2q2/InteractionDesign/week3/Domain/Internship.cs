using System;
using System.Collections.Generic;

namespace Week3
{
    public class Internship
    {
        // make Id settable so repository can restore DB ids
        public string Id { get; set; } = Guid.NewGuid().ToString();
        public string OrganizationId { get; init; }
        public string OrganizationName { get; init; }
        public string Title { get; init; }
        public string ShortDescription { get; init; }
        public string LongDescription { get; init; }
        public Period Period { get; init; }
        public InternshipCategory Category { get; init; }
        public List<ContactPerson> Contacts { get; } = new();
        public List<Student> AssignedStudents { get; } = new();

        // allow repository to set final grade when loading from DB
        public bool IsCompleted { get; private set; } = false;
        public double? FinalGrade { get; set; } = null;

        public Internship(string orgId, string orgName, string title, string shortDesc, string longDesc, Period period, InternshipCategory category)
        {
            OrganizationId = orgId;
            OrganizationName = orgName;
            Title = title;
            ShortDescription = shortDesc;
            LongDescription = longDesc;
            Period = period;
            Category = category;
        }

        public void MarkCompleted(double grade)
        {
            IsCompleted = true;
            FinalGrade = grade;
        }

        public override string ToString() => $"{OrganizationName} | {Title} | {Period} | {Category}" + (IsCompleted ? $" [Completed: {FinalGrade}]" : "");
    }
}