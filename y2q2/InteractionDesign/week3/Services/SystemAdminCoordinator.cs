using System;
using System.Collections.Generic;
using System.Linq;

namespace Week3
{
    public class SystemAdminCoordinator : ICoordinatorRepository
    {
        private readonly List<Organization> _organizations = new();
        private readonly List<Internship> _internships = new();
        private readonly List<Student> _students = new();

        public IReadOnlyList<Organization> Organizations => _organizations;
        public IReadOnlyList<Internship> Internships => _internships;
        public IReadOnlyList<Student> Students => _students;

        public bool AddOrganization(Organization org)
        {
            if (_organizations.Any(o => string.Equals(o.Name, org.Name, StringComparison.OrdinalIgnoreCase)
                                     && string.Equals(o.City, org.City, StringComparison.OrdinalIgnoreCase)))
                return false;
            _organizations.Add(org);
            return true;
        }

        public IEnumerable<Organization> GetOrganizationsOverview() =>
            _organizations.OrderBy(o => o.City).ThenBy(o => o.Name);

        public void AddInternship(Internship internship)
        {
            _internships.Add(internship);
        }

        public IEnumerable<Internship> GetInternshipsOverview(Period period, InternshipCategory? category = null) =>
            _internships.Where(i => i.Period.Year == period.Year && i.Period.Semester == period.Semester
                                && (category == null || i.Category == category))
                        .OrderBy(i => i.OrganizationName);

        public bool AssignStudentToInternship(Student student, string internshipId)
        {
            var internship = _internships.FirstOrDefault(i => i.Id == internshipId);
            if (internship == null) return false;

            // rule: prevent same student (by id) assigned to multiple internships in same period
            if (_internships.Any(i => i.AssignedStudents.Any(s => s.StudentId == student.StudentId)
                                     && i.Period.Year == internship.Period.Year && i.Period.Semester == internship.Period.Semester))
                return false;

            // if a student with same id exists in repository, use that instance (preserve other data)
            var existingStudent = _students.FirstOrDefault(s => s.StudentId == student.StudentId);
            if (existingStudent != null)
            {
                // update name if provided
                if (!string.IsNullOrWhiteSpace(student.FirstName)) existingStudent.FirstName = student.FirstName;
                if (!string.IsNullOrWhiteSpace(student.LastName)) existingStudent.LastName = student.LastName;
                student = existingStudent;
            }
            else
            {
                _students.Add(student);
            }

            // create a simple assignment object based on internship category and set on student
            student.CurrentAssignment = CreateAssignmentFromCategory(internship.Category, internship.Title);

            internship.AssignedStudents.Add(student);
            return true;
        }

        // helper to map category -> assignment subtype
        private Assignment CreateAssignmentFromCategory(InternshipCategory category, string title)
        {
            return category switch
            {
                InternshipCategory.Research => new ResearchAssignment(title),
                InternshipCategory.Minor => new MinorAssignment(title, module: "unknown"),
                InternshipCategory.Engineering => new EngineeringAssignment(title),
                _ => new ResearchAssignment(title)
            };
        }

        // Withdraw internship (remove internship, unassign students and remove internship contacts from org)
        public bool WithdrawInternship(string internshipId)
        {
            var internship = _internships.FirstOrDefault(i => i.Id == internshipId);
            if (internship == null) return false;

            // unassign and remove students associated with this internship
            foreach (var student in internship.AssignedStudents.ToList())
            {
                student.CurrentAssignment = null;
                var existing = _students.FirstOrDefault(s => s.StudentId == student.StudentId);
                if (existing != null) _students.Remove(existing);
            }

            // remove contact persons of this internship from the organisation (if present)
            var org = _organizations.FirstOrDefault(o => o.OrganizationId == internship.OrganizationId);
            if (org != null)
            {
                foreach (var contact in internship.Contacts.ToList())
                {
                    var match = org.Contacts.FirstOrDefault(c => c.Id == contact.Id);
                    if (match != null) org.Contacts.Remove(match);
                }
            }

            _internships.Remove(internship);
            return true;
        }

        // Mark internship completed with final grade
        public bool MarkInternshipCompleted(string internshipId, double finalGrade)
        {
            var internship = _internships.FirstOrDefault(i => i.Id == internshipId);
            if (internship == null) return false;
            internship.MarkCompleted(finalGrade);
            foreach (var student in internship.AssignedStudents)
            {
                if (student.CurrentAssignment != null) student.CurrentAssignment.IsCompleted = true;
            }
            return true;
        }

        // Remove (unassign) a student from an internship (student remains in student repo)
        public bool RemoveStudentFromInternship(string studentId, string internshipId)
        {
            var internship = _internships.FirstOrDefault(i => i.Id == internshipId);
            if (internship == null) return false;
            var student = internship.AssignedStudents.FirstOrDefault(s => s.StudentId == studentId);
            if (student == null) return false;

            student.CurrentAssignment = null;
            internship.AssignedStudents.Remove(student);

            return true;
        }

        // convenience queries
        public Organization? GetOrganizationById(string organizationId) =>
            _organizations.FirstOrDefault(o => o.OrganizationId == organizationId);

        public IEnumerable<Internship> GetInternshipsByOrganizationId(string organizationId) =>
            _internships.Where(i => i.OrganizationId == organizationId).OrderBy(i => i.Period.Year).ThenBy(i => i.Period.Semester);

        public IEnumerable<ContactPerson> GetContactPersonsForInternship(string internshipId)
        {
            var internship = _internships.FirstOrDefault(i => i.Id == internshipId);
            if (internship == null) return Enumerable.Empty<ContactPerson>();
            return internship.Contacts.OrderBy(c => c.LastName).ThenBy(c => c.FirstName);
        }

        public bool WithdrawInternshipSimple(string internshipId) // kept for backward compatibility
        {
            return WithdrawInternship(internshipId);
        }

        public bool AddStudent(Student student)
        {
            if (student == null || string.IsNullOrWhiteSpace(student.StudentId)) return false;
            var existing = _students.FirstOrDefault(s => s.StudentId == student.StudentId);
            if (existing != null)
            {
                if (!string.IsNullOrWhiteSpace(student.FirstName)) existing.FirstName = student.FirstName;
                if (!string.IsNullOrWhiteSpace(student.LastName)) existing.LastName = student.LastName;
                return true;
            }
            _students.Add(student);
            return true;
        }

        public bool AddContactPerson(string organizationId, ContactPerson contact)
        {
            if (contact == null || string.IsNullOrWhiteSpace(organizationId)) return false;
            var org = _organizations.FirstOrDefault(o => o.OrganizationId == organizationId);
            if (org == null) return false;
            if (string.IsNullOrWhiteSpace(contact.Id)) contact.Id = Guid.NewGuid().ToString();
            // avoid exact duplicate entry by id
            if (org.Contacts.Any(c => c.Id == contact.Id)) return true;
            org.Contacts.Add(contact);
            return true;
        }

        public IEnumerable<ContactPerson> GetContactPersonsByOrganization(string organizationId)
        {
            var org = _organizations.FirstOrDefault(o => o.OrganizationId == organizationId);
            if (org == null) return Enumerable.Empty<ContactPerson>();
            return org.Contacts;
        }
    }
}