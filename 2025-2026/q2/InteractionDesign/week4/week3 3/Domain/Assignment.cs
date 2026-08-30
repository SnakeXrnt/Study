using System;

namespace Week3
{
    public abstract class Assignment
    {
        public string Title { get; init; }
        public bool IsCompleted { get; set; }
        protected Assignment(string title) => Title = title;
        public virtual bool ValidateSpecifics() => !string.IsNullOrWhiteSpace(Title);
    }

    public class ResearchAssignment : Assignment { public ResearchAssignment(string t) : base(t) { } }

    public class MinorAssignment : Assignment
    {
        public string MinorModule { get; init; }
        public MinorAssignment(string t, string module) : base(t) { MinorModule = module; }
        public override bool ValidateSpecifics() => base.ValidateSpecifics() && !string.IsNullOrWhiteSpace(MinorModule);
    }

    public class EngineeringAssignment : Assignment { public EngineeringAssignment(string t) : base(t) { } }
}