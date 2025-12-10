using System.Collections.Generic;

namespace Week3
{
    public interface ICoordinatorRepository
    {
        IReadOnlyList<Organization> Organizations { get; }
        IReadOnlyList<Internship> Internships { get; }
        IReadOnlyList<Student> Students { get; }

        bool AddOrganization(Organization org);
        IEnumerable<Organization> GetOrganizationsOverview();

        void AddInternship(Internship internship);
        IEnumerable<Internship> GetInternshipsOverview(Period period, InternshipCategory? category = null);

        bool AssignStudentToInternship(Student student, string internshipId);
        bool RemoveStudentFromInternship(string studentId, string internshipId);

        bool WithdrawInternship(string internshipId);
        bool MarkInternshipCompleted(string internshipId, double finalGrade);

        // convenience queries
        Organization? GetOrganizationById(string organizationId);
        IEnumerable<Internship> GetInternshipsByOrganizationId(string organizationId);
        IEnumerable<ContactPerson> GetContactPersonsForInternship(string internshipId);

        // add student explicitly (upsert)
        bool AddStudent(Student student);

        // contact person operations
        bool AddContactPerson(string organizationId, ContactPerson contact);
        IEnumerable<ContactPerson> GetContactPersonsByOrganization(string organizationId);
    }
}