using System;
using System.Collections.Generic;

namespace Week3
{
    public class Organization
    {
        // made settable so reflection/property assignment from the repository works
        public string OrganizationId { get; set; } = Guid.NewGuid().ToString();
        public string Name { get; init; }
        public string Address { get; init; }
        public string City { get; init; }
        public string? Url { get; init; }
        public string? PhoneNumber { get; init; }
        public string? Email { get; init; }
        public List<ContactPerson> Contacts { get; } = new();

        public Organization(string name, string address, string city)
        {
            Name = name;
            Address = address;
            City = city;
        }

        // new ctor to allow creating with an explicit id (avoids reflection)
        public Organization(string organizationId, string name, string address, string city)
        {
            OrganizationId = organizationId;
            Name = name;
            Address = address;
            City = city;
        }

        public override string ToString() => $"{Name} - {City}";
    }
}