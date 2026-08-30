using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using Microsoft.Data.SqlClient;

namespace Week3
{
    public class MsSqlCoordinatorRepository : ICoordinatorRepository, IDisposable
    {
        private readonly string _connectionString;
        private SqlConnection? _conn;

        public MsSqlCoordinatorRepository(string connectionString)
        {
            _connectionString = connectionString ?? throw new ArgumentNullException(nameof(connectionString));
            _conn = new SqlConnection(_connectionString);
            _conn.Open();
            EnsureSchema();
        }

        private void EnsureSchema()
        {
            var sql = @"
IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = 'organizations')
BEGIN
CREATE TABLE organizations (
  organization_id NVARCHAR(36) PRIMARY KEY,
  name NVARCHAR(200) NOT NULL,
  address NVARCHAR(500),
  city NVARCHAR(100),
  url NVARCHAR(500),
  phone NVARCHAR(50),
  email NVARCHAR(200)
);
END

IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = 'contact_persons')
BEGIN
CREATE TABLE contact_persons (
  id NVARCHAR(36) PRIMARY KEY,
  organization_id NVARCHAR(36),
  first_name NVARCHAR(100),
  last_name NVARCHAR(100),
  email NVARCHAR(200),
  job_title NVARCHAR(200),
  phone NVARCHAR(50),
  department NVARCHAR(200),
  CONSTRAINT FK_contact_org FOREIGN KEY (organization_id) REFERENCES organizations(organization_id) ON DELETE CASCADE
);
END

IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = 'internships')
BEGIN
CREATE TABLE internships (
  id NVARCHAR(36) PRIMARY KEY,
  organization_id NVARCHAR(36),
  title NVARCHAR(500),
  short_description NVARCHAR(MAX),
  long_description NVARCHAR(MAX),
  year INT,
  semester INT,
  category INT,
  is_completed BIT DEFAULT 0,
  final_grade FLOAT NULL,
  CONSTRAINT FK_intern_org FOREIGN KEY (organization_id) REFERENCES organizations(organization_id) ON DELETE CASCADE
);
END

IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = 'internship_contacts')
BEGIN
CREATE TABLE internship_contacts (
  internship_id NVARCHAR(36),
  contact_id NVARCHAR(36),
  CONSTRAINT PK_internship_contacts PRIMARY KEY (internship_id, contact_id),
  -- do NOT cascade here to avoid multiple cascade paths
  CONSTRAINT FK_ic_intern FOREIGN KEY (internship_id) REFERENCES internships(id) ON DELETE NO ACTION,
  CONSTRAINT FK_ic_contact FOREIGN KEY (contact_id) REFERENCES contact_persons(id) ON DELETE NO ACTION
);
END

IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = 'students')
BEGIN
CREATE TABLE students (
  student_id NVARCHAR(50) PRIMARY KEY,
  first_name NVARCHAR(200),
  last_name NVARCHAR(200)
);
END

IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = 'internship_assignments')
BEGIN
CREATE TABLE internship_assignments (
  internship_id NVARCHAR(36),
  student_id NVARCHAR(50),
  CONSTRAINT PK_assign PRIMARY KEY (internship_id, student_id),
  CONSTRAINT FK_assign_intern FOREIGN KEY (internship_id) REFERENCES internships(id) ON DELETE CASCADE,
  CONSTRAINT FK_assign_student FOREIGN KEY (student_id) REFERENCES students(student_id) ON DELETE CASCADE
);
END
";
            using var cmd = _conn!.CreateCommand();
            cmd.CommandText = sql;
            cmd.ExecuteNonQuery();
        }

        private static string NewId() => Guid.NewGuid().ToString();

        public IReadOnlyList<Organization> Organizations => GetOrganizationsOverview().ToList();
        public IReadOnlyList<Internship> Internships => GetAllInternships().ToList();
        public IReadOnlyList<Student> Students => GetAllStudents().ToList();

        public bool AddOrganization(Organization org)
        {
            if (org == null) return false;
            using var check = _conn!.CreateCommand();
            check.CommandText = "SELECT COUNT(*) FROM organizations WHERE LOWER(name)=LOWER(@name) AND LOWER(city)=LOWER(@city)";
            check.Parameters.AddWithValue("@name", org.Name);
            check.Parameters.AddWithValue("@city", org.City);
            var exists = Convert.ToInt32(check.ExecuteScalar() ?? 0) > 0;
            if (exists) return false;

            using var cmd = _conn.CreateCommand();
            cmd.CommandText = @"INSERT INTO organizations (organization_id, name, address, city, url, phone, email)
VALUES (@id,@name,@address,@city,@url,@phone,@email)";
            cmd.Parameters.AddWithValue("@id", org.OrganizationId);
            cmd.Parameters.AddWithValue("@name", org.Name);
            cmd.Parameters.AddWithValue("@address", org.Address ?? (object)DBNull.Value);
            cmd.Parameters.AddWithValue("@city", org.City ?? (object)DBNull.Value);
            cmd.Parameters.AddWithValue("@url", org.Url ?? (object)DBNull.Value);
            cmd.Parameters.AddWithValue("@phone", org.PhoneNumber ?? (object)DBNull.Value);
            cmd.Parameters.AddWithValue("@email", org.Email ?? (object)DBNull.Value);
            cmd.ExecuteNonQuery();

            foreach (var c in org.Contacts)
            {
                using var ccmd = _conn.CreateCommand();
                ccmd.CommandText = @"MERGE contact_persons AS target
USING (SELECT @id AS id) AS src
ON (target.id = src.id)
WHEN MATCHED THEN 
  UPDATE SET first_name=@first, last_name=@last, email=@email, job_title=@job, phone=@phone, department=@dept, organization_id=@org
WHEN NOT MATCHED THEN
  INSERT (id, organization_id, first_name, last_name, email, job_title, phone, department)
  VALUES (@id,@org,@first,@last,@email,@job,@phone,@dept);";
                ccmd.Parameters.AddWithValue("@id", c.Id);
                ccmd.Parameters.AddWithValue("@org", org.OrganizationId);
                ccmd.Parameters.AddWithValue("@first", c.FirstName ?? (object)DBNull.Value);
                ccmd.Parameters.AddWithValue("@last", c.LastName ?? (object)DBNull.Value);
                ccmd.Parameters.AddWithValue("@email", c.Email ?? (object)DBNull.Value);
                ccmd.Parameters.AddWithValue("@job", c.JobTitle ?? (object)DBNull.Value);
                ccmd.Parameters.AddWithValue("@phone", c.PhoneNumber ?? (object)DBNull.Value);
                ccmd.Parameters.AddWithValue("@dept", c.Department ?? (object)DBNull.Value);
                ccmd.ExecuteNonQuery();
            }

            return true;
        }

        public IEnumerable<Organization> GetOrganizationsOverview()
        {
            var list = new List<Organization>();
            using var cmd = _conn!.CreateCommand();
            cmd.CommandText = "SELECT organization_id, name, address, city, url, phone, email FROM organizations ORDER BY city, name";
            using var rdr = cmd.ExecuteReader();
            while (rdr.Read())
            {
                // use new ctor with id to avoid reflection set errors
                var org = new Organization(
                    rdr.GetString(rdr.GetOrdinal("organization_id")),
                    rdr.GetString(rdr.GetOrdinal("name")),
                    rdr.IsDBNull(rdr.GetOrdinal("address")) ? "" : rdr.GetString(rdr.GetOrdinal("address")),
                    rdr.IsDBNull(rdr.GetOrdinal("city")) ? "" : rdr.GetString(rdr.GetOrdinal("city"))
                )
                {
                    Url = rdr.IsDBNull(rdr.GetOrdinal("url")) ? null : rdr.GetString(rdr.GetOrdinal("url")),
                    PhoneNumber = rdr.IsDBNull(rdr.GetOrdinal("phone")) ? null : rdr.GetString(rdr.GetOrdinal("phone")),
                    Email = rdr.IsDBNull(rdr.GetOrdinal("email")) ? null : rdr.GetString(rdr.GetOrdinal("email"))
                };
                list.Add(org);
            }
            rdr.Close();

            // load contacts per organization
            foreach (var org in list)
            {
                using var ccmd = _conn.CreateCommand();
                ccmd.CommandText = "SELECT id, first_name, last_name, email, job_title, phone, department FROM contact_persons WHERE organization_id=@org ORDER BY last_name, first_name";
                ccmd.Parameters.AddWithValue("@org", org.OrganizationId);
                using var cr = ccmd.ExecuteReader();
                while (cr.Read())
                {
                    var cp2 = new ContactPerson
                    {
                        FirstName = cr.IsDBNull(1) ? null : cr.GetString(1),
                        LastName = cr.IsDBNull(2) ? null : cr.GetString(2),
                        Email = cr.IsDBNull(3) ? null : cr.GetString(3),
                        JobTitle = cr.IsDBNull(4) ? null : cr.GetString(4),
                        PhoneNumber = cr.IsDBNull(5) ? null : cr.GetString(5),
                        Department = cr.IsDBNull(6) ? null : cr.GetString(6)
                    };
                    // set Id via reflection (ContactPerson.Id has init-only) - keep as before
                    typeof(ContactPerson).GetProperty("Id")!.SetValue(cp2, cr.GetString("id"));
                    org.Contacts.Add(cp2);
                }
                cr.Close();
            }

            return list;
        }

        public void AddInternship(Internship internship)
        {
            using var cmd = _conn!.CreateCommand();
            cmd.CommandText = @"INSERT INTO internships (id, organization_id, title, short_description, long_description, year, semester, category, is_completed, final_grade)
VALUES (@id,@org,@title,@short,@long,@year,@sem,@cat,0,NULL)";
            cmd.Parameters.AddWithValue("@id", internship.Id);
            cmd.Parameters.AddWithValue("@org", internship.OrganizationId);
            cmd.Parameters.AddWithValue("@title", internship.Title);
            cmd.Parameters.AddWithValue("@short", internship.ShortDescription ?? (object)DBNull.Value);
            cmd.Parameters.AddWithValue("@long", internship.LongDescription ?? (object)DBNull.Value);
            cmd.Parameters.AddWithValue("@year", internship.Period.Year);
            cmd.Parameters.AddWithValue("@sem", internship.Period.Semester);
            cmd.Parameters.AddWithValue("@cat", (int)internship.Category);
            cmd.ExecuteNonQuery();

            foreach (var c in internship.Contacts)
            {
                using var ccmd = _conn.CreateCommand();
                ccmd.CommandText = @"MERGE contact_persons AS target
USING (SELECT @id AS id) AS src
ON (target.id = src.id)
WHEN MATCHED THEN 
  UPDATE SET first_name=@first, last_name=@last, email=@email, job_title=@job, phone=@phone, department=@dept, organization_id=@org
WHEN NOT MATCHED THEN
  INSERT (id, organization_id, first_name, last_name, email, job_title, phone, department)
  VALUES (@id,@org,@first,@last,@email,@job,@phone,@dept);";
                ccmd.Parameters.AddWithValue("@id", c.Id);
                ccmd.Parameters.AddWithValue("@org", internship.OrganizationId);
                ccmd.Parameters.AddWithValue("@first", c.FirstName ?? (object)DBNull.Value);
                ccmd.Parameters.AddWithValue("@last", c.LastName ?? (object)DBNull.Value);
                ccmd.Parameters.AddWithValue("@email", c.Email ?? (object)DBNull.Value);
                ccmd.Parameters.AddWithValue("@job", c.JobTitle ?? (object)DBNull.Value);
                ccmd.Parameters.AddWithValue("@phone", c.PhoneNumber ?? (object)DBNull.Value);
                ccmd.Parameters.AddWithValue("@dept", c.Department ?? (object)DBNull.Value);
                ccmd.ExecuteNonQuery();

                using var link = _conn.CreateCommand();
                link.CommandText = "IF NOT EXISTS (SELECT * FROM internship_contacts WHERE internship_id=@iid AND contact_id=@cid) INSERT INTO internship_contacts (internship_id, contact_id) VALUES (@iid,@cid)";
                link.Parameters.AddWithValue("@iid", internship.Id);
                link.Parameters.AddWithValue("@cid", c.Id);
                link.ExecuteNonQuery();
            }
        }

        public IEnumerable<Internship> GetInternshipsOverview(Period period, InternshipCategory? category = null)
        {
            var list = new List<Internship>();
            using var cmd = _conn!.CreateCommand();
            cmd.CommandText = @"SELECT i.id, i.organization_id, o.name as orgname, i.title, i.short_description, i.long_description, i.year, i.semester, i.category, i.is_completed, i.final_grade
FROM internships i
LEFT JOIN organizations o ON o.organization_id = i.organization_id
WHERE i.year=@year AND i.semester=@sem";
            cmd.Parameters.AddWithValue("@year", period.Year);
            cmd.Parameters.AddWithValue("@sem", period.Semester);
            using var rdr = cmd.ExecuteReader();
            while (rdr.Read())
            {
                var cat = (InternshipCategory)Convert.ToInt32(rdr["category"]);
                if (category != null && cat != category) continue;

                var intern = new Internship(
                    rdr.GetString(rdr.GetOrdinal("organization_id")),
                    rdr["orgname"]?.ToString() ?? "",
                    rdr["title"]?.ToString() ?? "",
                    rdr["short_description"] == DBNull.Value ? "" : rdr.GetString(rdr.GetOrdinal("short_description")),
                    rdr["long_description"] == DBNull.Value ? "" : rdr.GetString(rdr.GetOrdinal("long_description")),
                    new Period(Convert.ToInt32(rdr["year"]), Convert.ToInt32(rdr["semester"])),
                    cat
                );
                // set Id (ctor uses orgid etc)
                intern.Id = rdr.GetString(rdr.GetOrdinal("id"));
                if (Convert.ToInt32(rdr["is_completed"]) == 1)
                {
                    var grade = rdr["final_grade"] == DBNull.Value ? (double?)null : Convert.ToDouble(rdr["final_grade"]);
                    if (grade != null) intern.MarkCompleted(grade.Value);
                }
                list.Add(intern);
            }
            rdr.Close();

            // now connection is free — load contacts and students for each internship
            foreach (var intern in list)
            {
                intern.Contacts.AddRange(GetContactPersonsForInternship(intern.Id));
                intern.AssignedStudents.AddRange(GetAssignedStudentsForInternship(intern.Id));
            }

            return list.OrderBy(i => i.OrganizationName).ToList();
        }

        private IEnumerable<Internship> GetAllInternships()
        {
            using var cmd = _conn!.CreateCommand();
            cmd.CommandText = "SELECT id, organization_id, title, short_description, long_description, year, semester, category, is_completed, final_grade FROM internships";
            using var rdr = cmd.ExecuteReader();
            var list = new List<Internship>();
            while (rdr.Read())
            {
                var intern = new Internship(
                    rdr.GetString(1),
                    "",
                    rdr["title"]?.ToString() ?? "",
                    rdr["short_description"] == DBNull.Value ? "" : rdr.GetString(3),
                    rdr["long_description"] == DBNull.Value ? "" : rdr.GetString(4),
                    new Period(Convert.ToInt32(rdr["year"]), Convert.ToInt32(rdr["semester"])),
                    (InternshipCategory)Convert.ToInt32(rdr["category"])
                );
                typeof(Internship).GetProperty("Id")!.SetValue(intern, rdr.GetString(0));
                list.Add(intern);
            }
            rdr.Close();
            return list;
        }

        private IEnumerable<Student> GetAllStudents()
        {
            var list = new List<Student>();
            using var cmd = _conn!.CreateCommand();
            cmd.CommandText = "SELECT student_id, first_name, last_name FROM students";
            using var rdr = cmd.ExecuteReader();
            while (rdr.Read())
            {
                var s = new Student(rdr.GetString(0), rdr.IsDBNull(1) ? "" : rdr.GetString(1), rdr.IsDBNull(2) ? "" : rdr.GetString(2));
                list.Add(s);
            }
            rdr.Close();
            return list;
        }

        public bool AddStudent(Student student)
        {
            if (student == null || string.IsNullOrWhiteSpace(student.StudentId)) return false;
            using var cmd = _conn!.CreateCommand();
            cmd.CommandText = @"
MERGE students AS target
USING (SELECT @sid AS student_id) AS src
ON (target.student_id = src.student_id)
WHEN MATCHED THEN 
  UPDATE SET first_name = @first, last_name = @last
WHEN NOT MATCHED THEN
  INSERT (student_id, first_name, last_name) VALUES (@sid, @first, @last);";
            cmd.Parameters.AddWithValue("@sid", student.StudentId);
            cmd.Parameters.AddWithValue("@first", student.FirstName ?? (object)DBNull.Value);
            cmd.Parameters.AddWithValue("@last", student.LastName ?? (object)DBNull.Value);
            cmd.ExecuteNonQuery();
            return true;
        }

        public bool AssignStudentToInternship(Student student, string internshipId)
        {
            using var cmd = _conn!.CreateCommand();
            cmd.CommandText = "SELECT year, semester FROM internships WHERE id=@iid";
            cmd.Parameters.AddWithValue("@iid", internshipId);
            using var rdr = cmd.ExecuteReader();
            if (!rdr.Read()) { rdr.Close(); return false; }
            var year = Convert.ToInt32(rdr["year"]); var sem = Convert.ToInt32(rdr["semester"]);
            rdr.Close();

            using var chk = _conn.CreateCommand();
            chk.CommandText = @"SELECT COUNT(*) FROM internship_assignments ia
JOIN internships i ON ia.internship_id = i.id
WHERE ia.student_id = @sid AND i.year = @year AND i.semester = @sem";
            chk.Parameters.AddWithValue("@sid", student.StudentId);
            chk.Parameters.AddWithValue("@year", year);
            chk.Parameters.AddWithValue("@sem", sem);
            var conflict = Convert.ToInt32(chk.ExecuteScalar() ?? 0) > 0;
            if (conflict) return false;

            using var ins = _conn.CreateCommand();
            ins.CommandText = @"MERGE students AS target
USING (SELECT @sid AS student_id) AS src
ON (target.student_id = src.student_id)
WHEN MATCHED THEN UPDATE SET first_name=@first, last_name=@last
WHEN NOT MATCHED THEN INSERT (student_id, first_name, last_name) VALUES (@sid,@first,@last);";
            ins.Parameters.AddWithValue("@sid", student.StudentId);
            ins.Parameters.AddWithValue("@first", student.FirstName ?? (object)DBNull.Value);
            ins.Parameters.AddWithValue("@last", student.LastName ?? (object)DBNull.Value);
            ins.ExecuteNonQuery();

            using var assign = _conn.CreateCommand();
            assign.CommandText = "IF NOT EXISTS (SELECT * FROM internship_assignments WHERE internship_id=@iid AND student_id=@sid) INSERT INTO internship_assignments (internship_id, student_id) VALUES (@iid,@sid)";
            assign.Parameters.AddWithValue("@iid", internshipId);
            assign.Parameters.AddWithValue("@sid", student.StudentId);
            assign.ExecuteNonQuery();

            return true;
        }

        public bool RemoveStudentFromInternship(string studentId, string internshipId)
        {
            using var cmd = _conn!.CreateCommand();
            cmd.CommandText = "DELETE FROM internship_assignments WHERE internship_id=@iid AND student_id=@sid";
            cmd.Parameters.AddWithValue("@iid", internshipId);
            cmd.Parameters.AddWithValue("@sid", studentId);
            var affected = cmd.ExecuteNonQuery();
            return affected > 0;
        }

        public bool WithdrawInternship(string internshipId)
        {
            if (string.IsNullOrWhiteSpace(internshipId)) return false;

            using var tran = _conn!.BeginTransaction();
            try
            {
                // read organisation id for the internship (needed later to cleanup contacts)
                string? orgId = null;
                using (var getOrg = _conn.CreateCommand())
                {
                    getOrg.Transaction = tran;
                    getOrg.CommandText = "SELECT organization_id FROM internships WHERE id=@iid";
                    getOrg.Parameters.AddWithValue("@iid", internshipId);
                    var o = getOrg.ExecuteScalar();
                    orgId = o == null || o == DBNull.Value ? null : o.ToString();
                }

                // remove student assignments for this internship
                using (var delAssign = _conn.CreateCommand())
                {
                    delAssign.Transaction = tran;
                    delAssign.CommandText = "DELETE FROM internship_assignments WHERE internship_id=@iid";
                    delAssign.Parameters.AddWithValue("@iid", internshipId);
                    delAssign.ExecuteNonQuery();
                }

                // remove internship <> contact links
                using (var delIC = _conn.CreateCommand())
                {
                    delIC.Transaction = tran;
                    delIC.CommandText = "DELETE FROM internship_contacts WHERE internship_id=@iid";
                    delIC.Parameters.AddWithValue("@iid", internshipId);
                    delIC.ExecuteNonQuery();
                }

                // delete the internship row
                int affected;
                using (var delIntern = _conn.CreateCommand())
                {
                    delIntern.Transaction = tran;
                    delIntern.CommandText = "DELETE FROM internships WHERE id=@iid";
                    delIntern.Parameters.AddWithValue("@iid", internshipId);
                    affected = delIntern.ExecuteNonQuery();
                }

                // optional: remove contact persons for the organisation that are no longer referenced by any internship
                if (!string.IsNullOrEmpty(orgId))
                {
                    using var delOrphanContacts = _conn.CreateCommand();
                    delOrphanContacts.Transaction = tran;
                    delOrphanContacts.CommandText =
                        @"DELETE FROM contact_persons
                          WHERE organization_id=@org
                            AND id NOT IN (SELECT contact_id FROM internship_contacts)";
                    delOrphanContacts.Parameters.AddWithValue("@org", orgId);
                    delOrphanContacts.ExecuteNonQuery();
                }

                tran.Commit();
                return affected > 0;
            }
            catch
            {
                try { tran.Rollback(); } catch { }
                return false;
            }
        }

        public bool MarkInternshipCompleted(string internshipId, double finalGrade)
        {
            using var cmd = _conn!.CreateCommand();
            cmd.CommandText = "UPDATE internships SET is_completed=1, final_grade=@grade WHERE id=@iid";
            cmd.Parameters.AddWithValue("@grade", finalGrade);
            cmd.Parameters.AddWithValue("@iid", internshipId);
            var affected = cmd.ExecuteNonQuery();
            return affected > 0;
        }

        public Organization? GetOrganizationById(string organizationId)
        {
            using var cmd = _conn!.CreateCommand();
            cmd.CommandText = "SELECT organization_id, name, address, city, url, phone, email FROM organizations WHERE organization_id=@id";
            cmd.Parameters.AddWithValue("@id", organizationId);
            using var rdr = cmd.ExecuteReader();
            if (!rdr.Read()) { rdr.Close(); return null; }
            var org = new Organization(
                rdr.GetString(1),
                rdr.IsDBNull(2) ? "" : rdr.GetString(2),
                rdr.IsDBNull(3) ? "" : rdr.GetString(3))
            {
                Url = rdr.IsDBNull(4) ? null : rdr.GetString(4),
                PhoneNumber = rdr.IsDBNull(5) ? null : rdr.GetString(5),
                Email = rdr.IsDBNull(6) ? null : rdr.GetString(6)
            };
            typeof(Organization).GetProperty("OrganizationId")!.SetValue(org, rdr.GetString(0));
            rdr.Close();

            using var ccmd = _conn.CreateCommand();
            ccmd.CommandText = "SELECT id, first_name, last_name, email, job_title, phone, department FROM contact_persons WHERE organization_id=@org ORDER BY last_name, first_name";
            ccmd.Parameters.AddWithValue("@org", organizationId);
            using var cr = ccmd.ExecuteReader();
            while (cr.Read())
            {
                var cp = new ContactPerson
                {
                    FirstName = cr.IsDBNull(1) ? null : cr.GetString(1),
                    LastName = cr.IsDBNull(2) ? null : cr.GetString(2),
                    Email = cr.IsDBNull(3) ? null : cr.GetString(3),
                    JobTitle = cr.IsDBNull(4) ? null : cr.GetString(4),
                    PhoneNumber = cr.IsDBNull(5) ? null : cr.GetString(5),
                    Department = cr.IsDBNull(6) ? null : cr.GetString(6)
                };
                typeof(ContactPerson).GetProperty("Id")!.SetValue(cp, cr.GetString(0));
                org.Contacts.Add(cp);
            }
            cr.Close();

            return org;
        }

        public IEnumerable<Internship> GetInternshipsByOrganizationId(string organizationId)
        {
            using var cmd = _conn!.CreateCommand();
            cmd.CommandText = @"SELECT id, title, short_description, long_description, year, semester, category, is_completed, final_grade
FROM internships WHERE organization_id=@org ORDER BY year, semester";
            cmd.Parameters.AddWithValue("@org", organizationId);
            using var rdr = cmd.ExecuteReader();
            var list = new List<Internship>();
            while (rdr.Read())
            {
                var intern = new Internship(
                    organizationId,
                    "",
                    rdr["title"]?.ToString() ?? "",
                    rdr["short_description"] == DBNull.Value ? "" : rdr.GetString(3),
                    rdr["long_description"] == DBNull.Value ? "" : rdr.GetString(4),
                    new Period(Convert.ToInt32(rdr["year"]), Convert.ToInt32(rdr["semester"])),
                    (InternshipCategory)Convert.ToInt32(rdr["category"])
                );
                typeof(Internship).GetProperty("Id")!.SetValue(intern, rdr.GetString(0));
                list.Add(intern);
            }
            rdr.Close();
            return list;
        }

        public IEnumerable<ContactPerson> GetContactPersonsForInternship(string internshipId)
        {
            var list = new List<ContactPerson>();
            using var cmd = _conn!.CreateCommand();
            cmd.CommandText = @"SELECT cp.id, cp.first_name, cp.last_name, cp.email, cp.job_title, cp.phone, cp.department
FROM contact_persons cp
JOIN internship_contacts ic ON ic.contact_id = cp.id
WHERE ic.internship_id = @iid
ORDER BY cp.last_name, cp.first_name";
            cmd.Parameters.AddWithValue("@iid", internshipId);
            using var rdr = cmd.ExecuteReader();
            while (rdr.Read())
            {
                var cp = new ContactPerson
                {
                    FirstName = rdr.IsDBNull(1) ? null : rdr.GetString(1),
                    LastName = rdr.IsDBNull(2) ? null : rdr.GetString(2),
                    Email = rdr.IsDBNull(3) ? null : rdr.GetString(3),
                    JobTitle = rdr.IsDBNull(4) ? null : rdr.GetString(4),
                    PhoneNumber = rdr.IsDBNull(5) ? null : rdr.GetString(5),
                    Department = rdr.IsDBNull(6) ? null : rdr.GetString(6)
                };
                typeof(ContactPerson).GetProperty("Id")!.SetValue(cp, rdr.GetString(0));
                list.Add(cp);
            }
            rdr.Close();
            return list;
        }

        private IEnumerable<Student> GetAssignedStudentsForInternship(string internshipId)
        {
            var list = new List<Student>();
            using var cmd = _conn!.CreateCommand();
            cmd.CommandText = @"SELECT s.student_id, s.first_name, s.last_name
FROM students s
JOIN internship_assignments ia ON ia.student_id = s.student_id
WHERE ia.internship_id = @iid";
            cmd.Parameters.AddWithValue("@iid", internshipId);
            using var rdr = cmd.ExecuteReader();
            while (rdr.Read())
            {
                list.Add(new Student(rdr.GetString(0), rdr.IsDBNull(1) ? "" : rdr.GetString(1), rdr.IsDBNull(2) ? "" : rdr.GetString(2)));
            }
            rdr.Close();
            return list;
        }

        public bool AddContactPerson(string organizationId, ContactPerson contact)
        {
            if (contact == null || string.IsNullOrWhiteSpace(organizationId)) return false;
            using var cmd = _conn!.CreateCommand();
            cmd.CommandText = @"
INSERT INTO contact_persons (id, organization_id, first_name, last_name, email, job_title, phone, department)
VALUES (@id, @org, @first, @last, @email, @job, @phone, @dept);";
            cmd.Parameters.AddWithValue("@id", string.IsNullOrWhiteSpace(contact.Id) ? Guid.NewGuid().ToString() : contact.Id);
            cmd.Parameters.AddWithValue("@org", organizationId);
            cmd.Parameters.AddWithValue("@first", contact.FirstName ?? (object)DBNull.Value);
            cmd.Parameters.AddWithValue("@last", contact.LastName ?? (object)DBNull.Value);
            cmd.Parameters.AddWithValue("@email", contact.Email ?? (object)DBNull.Value);
            cmd.Parameters.AddWithValue("@job", contact.JobTitle ?? (object)DBNull.Value);
            cmd.Parameters.AddWithValue("@phone", contact.PhoneNumber ?? (object)DBNull.Value);
            cmd.Parameters.AddWithValue("@dept", contact.Department ?? (object)DBNull.Value);
            cmd.ExecuteNonQuery();
            return true;
        }

        public IEnumerable<ContactPerson> GetContactPersonsByOrganization(string organizationId)
        {
            var list = new List<ContactPerson>();
            using var cmd = _conn!.CreateCommand();
            cmd.CommandText = "SELECT id, first_name, last_name, email, job_title, phone, department FROM contact_persons WHERE organization_id = @org ORDER BY last_name, first_name";
            cmd.Parameters.AddWithValue("@org", organizationId);
            using var rdr = cmd.ExecuteReader();
            while (rdr.Read())
            {
                var cp = new ContactPerson
                {
                    FirstName = rdr.IsDBNull(1) ? null : rdr.GetString(1),
                    LastName = rdr.IsDBNull(2) ? null : rdr.GetString(2),
                    Email = rdr.IsDBNull(3) ? null : rdr.GetString(3),
                    JobTitle = rdr.IsDBNull(4) ? null : rdr.GetString(4),
                    PhoneNumber = rdr.IsDBNull(5) ? null : rdr.GetString(5),
                    Department = rdr.IsDBNull(6) ? null : rdr.GetString(6)
                };
                typeof(ContactPerson).GetProperty("Id")!.SetValue(cp, rdr.GetString(0));
                list.Add(cp);
            }
            rdr.Close();
            return list;
        }

        public void Dispose()
        {
            if (_conn != null) { try { _conn.Close(); } catch { } _conn = null; }
        }
    }
}