using System;
using System.Collections.Generic;
using System.Linq;
using MySql.Data.MySqlClient;

namespace Week3
{
    public class MySqlCoordinatorRepository : ICoordinatorRepository, IDisposable
    {
        private readonly string _connectionString;
        private MySqlConnection? _conn;

        public MySqlCoordinatorRepository(string connectionString)
        {
            _connectionString = connectionString ?? throw new ArgumentNullException(nameof(connectionString));
            _conn = new MySqlConnection(_connectionString);
            _conn.Open();
            EnsureSchema();
        }

        private void EnsureSchema()
        {
            var sql = @"
CREATE TABLE IF NOT EXISTS organizations (
  organization_id VARCHAR(36) PRIMARY KEY,
  name VARCHAR(200) NOT NULL,
  address VARCHAR(500),
  city VARCHAR(100),
  url VARCHAR(500),
  phone VARCHAR(50),
  email VARCHAR(200)
);

CREATE TABLE IF NOT EXISTS contact_persons (
  id VARCHAR(36) PRIMARY KEY,
  organization_id VARCHAR(36),
  first_name VARCHAR(100),
  last_name VARCHAR(100),
  email VARCHAR(200),
  job_title VARCHAR(200),
  phone VARCHAR(50),
  department VARCHAR(200),
  CONSTRAINT FK_contact_org FOREIGN KEY (organization_id) REFERENCES organizations(organization_id) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS internships (
  id VARCHAR(36) PRIMARY KEY,
  organization_id VARCHAR(36),
  title VARCHAR(500),
  short_description TEXT,
  long_description TEXT,
  year INT,
  semester INT,
  category INT,
  is_completed TINYINT(1) DEFAULT 0,
  final_grade DOUBLE NULL,
  CONSTRAINT FK_intern_org FOREIGN KEY (organization_id) REFERENCES organizations(organization_id) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS internship_contacts (
  internship_id VARCHAR(36),
  contact_id VARCHAR(36),
  PRIMARY KEY (internship_id, contact_id),
  CONSTRAINT FK_ic_intern FOREIGN KEY (internship_id) REFERENCES internships(id) ON DELETE NO ACTION,
  CONSTRAINT FK_ic_contact FOREIGN KEY (contact_id) REFERENCES contact_persons(id) ON DELETE NO ACTION
);

CREATE TABLE IF NOT EXISTS students (
  student_id VARCHAR(50) PRIMARY KEY,
  first_name VARCHAR(200),
  last_name VARCHAR(200)
);

CREATE TABLE IF NOT EXISTS internship_assignments (
  internship_id VARCHAR(36),
  student_id VARCHAR(50),
  PRIMARY KEY (internship_id, student_id),
  CONSTRAINT FK_assign_intern FOREIGN KEY (internship_id) REFERENCES internships(id) ON DELETE CASCADE,
  CONSTRAINT FK_assign_student FOREIGN KEY (student_id) REFERENCES students(student_id) ON DELETE CASCADE
);
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
                ccmd.CommandText = @"
INSERT INTO contact_persons (id, organization_id, first_name, last_name, email, job_title, phone, department)
VALUES (@id,@org,@first,@last,@email,@job,@phone,@dept)
ON DUPLICATE KEY UPDATE first_name=VALUES(first_name), last_name=VALUES(last_name), email=VALUES(email), job_title=VALUES(job_title), phone=VALUES(phone), department=VALUES(department), organization_id=VALUES(organization_id);";
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
                var org = new Organization(
                    rdr.GetString("organization_id"),
                    rdr.GetString("name"),
                    rdr.IsDBNull("address") ? "" : rdr.GetString("address"),
                    rdr.IsDBNull("city") ? "" : rdr.GetString("city")
                )
                {
                    Url = rdr.IsDBNull("url") ? null : rdr.GetString("url"),
                    PhoneNumber = rdr.IsDBNull("phone") ? null : rdr.GetString("phone"),
                    Email = rdr.IsDBNull("email") ? null : rdr.GetString("email")
                };
                list.Add(org);
            }
            rdr.Close();

            foreach (var org in list)
            {
                using var ccmd = _conn.CreateCommand();
                ccmd.CommandText = "SELECT id, first_name, last_name, email, job_title, phone, department FROM contact_persons WHERE organization_id=@org ORDER BY last_name, first_name";
                ccmd.Parameters.AddWithValue("@org", org.OrganizationId);
                using var cr = ccmd.ExecuteReader();
                while (cr.Read())
                {
                    var cp = new ContactPerson
                    {
                        Id = cr.GetString("id"),
                        FirstName = cr.IsDBNull("first_name") ? null : cr.GetString("first_name"),
                        LastName = cr.IsDBNull("last_name") ? null : cr.GetString("last_name"),
                        Email = cr.IsDBNull("email") ? null : cr.GetString("email"),
                        JobTitle = cr.IsDBNull("job_title") ? null : cr.GetString("job_title"),
                        PhoneNumber = cr.IsDBNull("phone") ? null : cr.GetString("phone"),
                        Department = cr.IsDBNull("department") ? null : cr.GetString("department")
                    };
                    org.Contacts.Add(cp);
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
                ccmd.CommandText = @"
INSERT INTO contact_persons (id, organization_id, first_name, last_name, email, job_title, phone, department)
VALUES (@id,@org,@first,@last,@email,@job,@phone,@dept)
ON DUPLICATE KEY UPDATE first_name=VALUES(first_name), last_name=VALUES(last_name), email=VALUES(email), job_title=VALUES(job_title), phone=VALUES(phone), department=VALUES(department), organization_id=VALUES(organization_id);";
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
                link.CommandText = "INSERT IGNORE INTO internship_contacts (internship_id, contact_id) VALUES (@iid, @cid)";
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
                    rdr.GetString("organization_id"),
                    rdr["orgname"]?.ToString() ?? "",
                    rdr["title"]?.ToString() ?? "",
                    rdr["short_description"] == DBNull.Value ? "" : rdr.GetString("short_description"),
                    rdr["long_description"] == DBNull.Value ? "" : rdr.GetString("long_description"),
                    new Period(Convert.ToInt32(rdr["year"]), Convert.ToInt32(rdr["semester"])),
                    cat
                );
                intern.Id = rdr.GetString("id");
                if (Convert.ToInt32(rdr["is_completed"]) == 1)
                {
                    var grade = rdr["final_grade"] == DBNull.Value ? (double?)null : Convert.ToDouble(rdr["final_grade"]);
                    if (grade != null) intern.MarkCompleted(grade.Value);
                }
                list.Add(intern);
            }
            rdr.Close();

            foreach (var intern in list)
            {
                intern.Contacts.AddRange(GetContactPersonsForInternship(intern.Id));
                intern.AssignedStudents.AddRange(GetAssignedStudentsForInternship(intern.Id));
            }

            return list.OrderBy(i => i.OrganizationName).ToList();
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
                    Id = rdr.GetString("id"),
                    FirstName = rdr.IsDBNull("first_name") ? null : rdr.GetString("first_name"),
                    LastName = rdr.IsDBNull("last_name") ? null : rdr.GetString("last_name"),
                    Email = rdr.IsDBNull("email") ? null : rdr.GetString("email"),
                    JobTitle = rdr.IsDBNull("job_title") ? null : rdr.GetString("job_title"),
                    PhoneNumber = rdr.IsDBNull("phone") ? null : rdr.GetString("phone"),
                    Department = rdr.IsDBNull("department") ? null : rdr.GetString("department")
                };
                list.Add(cp);
            }
            rdr.Close();
            return list;
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
                    rdr.GetString("organization_id"),
                    "",
                    rdr["title"]?.ToString() ?? "",
                    rdr["short_description"] == DBNull.Value ? "" : rdr.GetString("short_description"),
                    rdr["long_description"] == DBNull.Value ? "" : rdr.GetString("long_description"),
                    new Period(Convert.ToInt32(rdr["year"]), Convert.ToInt32(rdr["semester"])),
                    (InternshipCategory)Convert.ToInt32(rdr["category"])
                );
                intern.Id = rdr.GetString("id");
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
                var s = new Student(rdr.GetString("student_id"), rdr.IsDBNull("first_name") ? "" : rdr.GetString("first_name"), rdr.IsDBNull("last_name") ? "" : rdr.GetString("last_name"));
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
INSERT INTO students (student_id, first_name, last_name)
VALUES (@sid, @first, @last)
ON DUPLICATE KEY UPDATE first_name=VALUES(first_name), last_name=VALUES(last_name);";
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

            using var upsert = _conn.CreateCommand();
            upsert.CommandText = @"
INSERT INTO students (student_id, first_name, last_name) VALUES (@sid,@first,@last)
ON DUPLICATE KEY UPDATE first_name=VALUES(first_name), last_name=VALUES(last_name);";
            upsert.Parameters.AddWithValue("@sid", student.StudentId);
            upsert.Parameters.AddWithValue("@first", student.FirstName ?? (object)DBNull.Value);
            upsert.Parameters.AddWithValue("@last", student.LastName ?? (object)DBNull.Value);
            upsert.ExecuteNonQuery();

            using var assign = _conn.CreateCommand();
            assign.CommandText = "INSERT IGNORE INTO internship_assignments (internship_id, student_id) VALUES (@iid, @sid)";
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
                string? orgId = null;
                using (var getOrg = _conn.CreateCommand())
                {
                    getOrg.Transaction = tran;
                    getOrg.CommandText = "SELECT organization_id FROM internships WHERE id=@iid";
                    getOrg.Parameters.AddWithValue("@iid", internshipId);
                    var o = getOrg.ExecuteScalar();
                    orgId = o == null || o == DBNull.Value ? null : o.ToString();
                }

                using (var delAssign = _conn.CreateCommand())
                {
                    delAssign.Transaction = tran;
                    delAssign.CommandText = "DELETE FROM internship_assignments WHERE internship_id=@iid";
                    delAssign.Parameters.AddWithValue("@iid", internshipId);
                    delAssign.ExecuteNonQuery();
                }

                using (var delIC = _conn.CreateCommand())
                {
                    delIC.Transaction = tran;
                    delIC.CommandText = "DELETE FROM internship_contacts WHERE internship_id=@iid";
                    delIC.Parameters.AddWithValue("@iid", internshipId);
                    delIC.ExecuteNonQuery();
                }

                int affected;
                using (var delIntern = _conn.CreateCommand())
                {
                    delIntern.Transaction = tran;
                    delIntern.CommandText = "DELETE FROM internships WHERE id=@iid";
                    delIntern.Parameters.AddWithValue("@iid", internshipId);
                    affected = delIntern.ExecuteNonQuery();
                }

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
                rdr.GetString("organization_id"),
                rdr.GetString("name"),
                rdr.IsDBNull("address") ? "" : rdr.GetString("address"),
                rdr.IsDBNull("city") ? "" : rdr.GetString("city")
            )
            {
                Url = rdr.IsDBNull("url") ? null : rdr.GetString("url"),
                PhoneNumber = rdr.IsDBNull("phone") ? null : rdr.GetString("phone"),
                Email = rdr.IsDBNull("email") ? null : rdr.GetString("email")
            };
            rdr.Close();

            using var ccmd = _conn.CreateCommand();
            ccmd.CommandText = "SELECT id, first_name, last_name, email, job_title, phone, department FROM contact_persons WHERE organization_id=@org ORDER BY last_name, first_name";
            ccmd.Parameters.AddWithValue("@org", organizationId);
            using var cr = ccmd.ExecuteReader();
            while (cr.Read())
            {
                var cp = new ContactPerson
                {
                    Id = cr.GetString("id"),
                    FirstName = cr.IsDBNull("first_name") ? null : cr.GetString("first_name"),
                    LastName = cr.IsDBNull("last_name") ? null : cr.GetString("last_name"),
                    Email = cr.IsDBNull("email") ? null : cr.GetString("email"),
                    JobTitle = cr.IsDBNull("job_title") ? null : cr.GetString("job_title"),
                    PhoneNumber = cr.IsDBNull("phone") ? null : cr.GetString("phone"),
                    Department = cr.IsDBNull("department") ? null : cr.GetString("department")
                };
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
                    rdr["short_description"] == DBNull.Value ? "" : rdr.GetString("short_description"),
                    rdr["long_description"] == DBNull.Value ? "" : rdr.GetString("long_description"),
                    new Period(Convert.ToInt32(rdr["year"]), Convert.ToInt32(rdr["semester"])),
                    (InternshipCategory)Convert.ToInt32(rdr["category"])
                );
                intern.Id = rdr.GetString("id");
                list.Add(intern);
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
                list.Add(new Student(rdr.GetString("student_id"), rdr.IsDBNull("first_name") ? "" : rdr.GetString("first_name"), rdr.IsDBNull("last_name") ? "" : rdr.GetString("last_name")));
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
VALUES (@id,@org,@first,@last,@email,@job,@phone,@dept)
ON DUPLICATE KEY UPDATE first_name=VALUES(first_name), last_name=VALUES(last_name), email=VALUES(email), job_title=VALUES(job_title), phone=VALUES(phone), department=VALUES(department), organization_id=VALUES(organization_id);";
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
            cmd.CommandText = "SELECT id, first_name, last_name, email, job_title, phone, department FROM contact_persons WHERE organization_id=@org ORDER BY last_name, first_name";
            cmd.Parameters.AddWithValue("@org", organizationId);
            using var rdr = cmd.ExecuteReader();
            while (rdr.Read())
            {
                var cp = new ContactPerson
                {
                    Id = rdr.IsDBNull("id") ? Guid.NewGuid().ToString() : rdr.GetString("id"),
                    FirstName = rdr.IsDBNull("first_name") ? null : rdr.GetString("first_name"),
                    LastName = rdr.IsDBNull("last_name") ? null : rdr.GetString("last_name"),
                    Email = rdr.IsDBNull("email") ? null : rdr.GetString("email"),
                    JobTitle = rdr.IsDBNull("job_title") ? null : rdr.GetString("job_title"),
                    PhoneNumber = rdr.IsDBNull("phone") ? null : rdr.GetString("phone"),
                    Department = rdr.IsDBNull("department") ? null : rdr.GetString("department")
                };
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