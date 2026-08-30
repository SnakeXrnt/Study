using System;

namespace Week3
{
    public class ContactPerson
    {
        // make Id settable so repository can restore DB ids without reflection errors
        public string Id { get; set; } = Guid.NewGuid().ToString();
        public string? FirstName { get; init; }
        public string? LastName { get; init; }
        public string? Email { get; init; }
        public string? JobTitle { get; init; }
        public string? PhoneNumber { get; init; }
        public string? Department { get; init; }

        public override string ToString() => $"{FirstName ?? ""} {LastName ?? ""} ({Email ?? "no-email"})";
    }
}