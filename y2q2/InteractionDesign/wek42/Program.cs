using System;
using System.Linq;
using Week3;

class Program
{
    static ICoordinatorRepository coordinator = null!;

    static void Main()
    {
        var conn = Environment.GetEnvironmentVariable("SIS_CONN") ?? "Server=localhost;Port=3306;Database=sis;Uid=appuser;Pwd=BalkanMadman123IsZURAB;";
        using var repo = new MySqlCoordinatorRepository(conn);
        coordinator = repo;

        SeedSampleDataIfEmpty();

        while (true)
        {
            Console.WriteLine();
            Console.WriteLine("Are you a (1) Coordinator or (2) Student? (q to quit)");
            Console.Write("Choose: ");
            var mode = Console.ReadLine();
            if (mode == "q") break;
            if (mode == "1") CoordinatorMenu();
            else if (mode == "2") StudentMenu();
        }
    }

    static void SeedSampleDataIfEmpty()
    {
        if (coordinator.Organizations.Count > 0) return;
        SeedSampleData();
    }

    static void SeedSampleData()
    {
        var org = new Organization("Acme Research", "Main 1", "Enschede") { Email = "info@acme.nl", Url = "https://acme.example" };
        var cp = new ContactPerson { FirstName = "Jan", LastName = "Jansen", Email = "j.jansen@acme.nl", JobTitle = "Manager" };
        org.Contacts.Add(cp);
        coordinator.AddOrganization(org);

        var internship = new Internship(org.OrganizationId, org.Name, "Smart Sensors", "Short desc", "Long description", new Period(2025, 1), InternshipCategory.Research);
        internship.Contacts.Add(cp);
        coordinator.AddInternship(internship);
    }

    static void CoordinatorMenu()
    {
        while (true)
        {
            Console.Clear(); // clear before showing menu
            Console.WriteLine("Coordinator Menu:");
            Console.WriteLine("(1) List Orgs");
            Console.WriteLine("(2) Add Org");
            Console.WriteLine("(3) List Internships");
            Console.WriteLine("(4) Withdraw Internship");
            Console.WriteLine("(5) Mark Completed");
            Console.WriteLine("(6) Remove Student");
            Console.WriteLine("(7) Add Internship");
            Console.WriteLine("(8) Add Student");
            Console.WriteLine("(9) List Students");
            Console.WriteLine("(10) List Contacts");
            Console.WriteLine("(11) Add Contact");
            Console.WriteLine("(b) Back");
            Console.Write("Choose: ");
            var cmd = Console.ReadLine();
            if (cmd == "b") break;

            if (cmd == "1")
            {
                Console.Clear();
                Console.WriteLine("Organizations:");
                foreach (var o in coordinator.GetOrganizationsOverview())
                    Console.WriteLine($"{o.OrganizationId} - {o}");
                Console.WriteLine();
                Console.WriteLine("Press Enter to continue...");
                Console.ReadLine();
            }
            else if (cmd == "2")
            {
                Console.Clear();
                Console.Write("Name: "); var name = Console.ReadLine() ?? "";
                Console.Write("Address: "); var address = Console.ReadLine() ?? "";
                Console.Write("City: "); var city = Console.ReadLine() ?? "";
                var org = new Organization(name, address, city);
                if (!coordinator.AddOrganization(org)) Console.WriteLine("Duplicate organization.");
                else
                {
                    Console.WriteLine($"Added {org.OrganizationId}");
                    Console.Write("Add a contact now? (y/n): ");
                    var add = Console.ReadLine();
                    if (add?.ToLower() == "y")
                    {
                        var cp = PromptContactFields();
                        if (cp != null) coordinator.AddContactPerson(org.OrganizationId, cp);
                        Console.WriteLine("Contact added.");
                    }
                }
                Console.WriteLine("Press Enter to continue...");
                Console.ReadLine();
            }
            else if (cmd == "3")
            {
                Console.Clear();
                Console.Write("Year: "); var y = int.Parse(Console.ReadLine() ?? "0");
                Console.Write("Semester (1 or 2): "); var s = int.Parse(Console.ReadLine() ?? "0");
                var list = coordinator.GetInternshipsOverview(new Period(y, s));
                Console.Clear();
                Console.WriteLine("Internships:");
                foreach (var i in list) Console.WriteLine($"{i.Id} - {i}");
                Console.WriteLine();
                Console.WriteLine("Press Enter to continue...");
                Console.ReadLine();
            }
            else if (cmd == "4")
            {
                Console.Clear();
                Console.Write("Internship Id to withdraw: "); var id = Console.ReadLine();
                if (!string.IsNullOrWhiteSpace(id) && coordinator.WithdrawInternship(id)) Console.WriteLine("Withdrawn.");
                else Console.WriteLine("Not found or failed.");
                Console.WriteLine("Press Enter to continue...");
                Console.ReadLine();
            }
            else if (cmd == "5")
            {
                Console.Clear();
                Console.Write("Internship Id to mark completed: "); var id = Console.ReadLine();
                Console.Write("Final grade (numeric): "); var raw = Console.ReadLine();
                if (double.TryParse(raw, out var grade) && !string.IsNullOrWhiteSpace(id) && coordinator.MarkInternshipCompleted(id, grade)) Console.WriteLine("Marked completed.");
                else Console.WriteLine("Failed to mark completed (invalid id or grade).");
                Console.WriteLine("Press Enter to continue...");
                Console.ReadLine();
            }
            else if (cmd == "6")
            {
                Console.Clear();
                Console.Write("Internship Id: "); var iid = Console.ReadLine();
                Console.Write("Student Id to remove: "); var sid = Console.ReadLine();
                if (!string.IsNullOrWhiteSpace(iid) && !string.IsNullOrWhiteSpace(sid) && coordinator.RemoveStudentFromInternship(sid, iid)) Console.WriteLine("Student removed from internship.");
                else Console.WriteLine("Failed to remove student (check ids).");
                Console.WriteLine("Press Enter to continue...");
                Console.ReadLine();
            }
            else if (cmd == "7")
            {
                Console.Clear();
                AddInternshipPrompt();
                Console.WriteLine("Press Enter to continue...");
                Console.ReadLine();
            }
            else if (cmd == "8")
            {
                Console.Clear();
                AddStudentPrompt();
                Console.WriteLine("Press Enter to continue...");
                Console.ReadLine();
            }
            else if (cmd == "9")
            {
                Console.Clear();
                var students = coordinator.Students.ToList();
                if (!students.Any()) { Console.WriteLine("No students registered."); }
                else
                {
                    Console.WriteLine("Students:");
                    foreach (var s in students) Console.WriteLine($"{s.StudentId} - {s.FirstName} {s.LastName}");
                }
                Console.WriteLine();
                Console.WriteLine("Press Enter to continue...");
                Console.ReadLine();
            }
            else if (cmd == "10")
            {
                Console.Clear();
                Console.WriteLine("List contacts by: (1) All organizations (2) Specific organization");
                var choice = Console.ReadLine();
                if (choice == "1")
                {
                    foreach (var org in coordinator.GetOrganizationsOverview())
                    {
                        Console.WriteLine();
                        Console.WriteLine($"Org: {org.Name} ({org.OrganizationId})");
                        var cps = coordinator.GetContactPersonsByOrganization(org.OrganizationId);
                        foreach (var cp in cps) PrintContact(cp);
                    }
                }
                else
                {
                    var orgs = coordinator.GetOrganizationsOverview().ToList();
                    for (int i = 0; i < orgs.Count; i++) Console.WriteLine($"{i+1}. {orgs[i].Name} ({orgs[i].OrganizationId})");
                    Console.Write("Select organization number: ");
                    if (int.TryParse(Console.ReadLine(), out var idx) && idx >= 1 && idx <= orgs.Count)
                    {
                        var org = orgs[idx - 1];
                        var cps = coordinator.GetContactPersonsByOrganization(org.OrganizationId);
                        Console.Clear();
                        Console.WriteLine($"Contacts for {org.Name}:");
                        foreach (var cp in cps) PrintContact(cp);
                    }
                }
                Console.WriteLine();
                Console.WriteLine("Press Enter to continue...");
                Console.ReadLine();
            }
            else if (cmd == "11")
            {
                Console.Clear();
                var orgs2 = coordinator.GetOrganizationsOverview().ToList();
                if (!orgs2.Any()) { Console.WriteLine("No organizations. Add org first."); Console.WriteLine("Press Enter to continue..."); Console.ReadLine(); continue; }
                for (int i = 0; i < orgs2.Count; i++) Console.WriteLine($"{i+1}. {orgs2[i].Name} ({orgs2[i].OrganizationId})");
                Console.Write("Select organization number to add contact to: ");
                if (!int.TryParse(Console.ReadLine(), out var sel) || sel < 1 || sel > orgs2.Count) { Console.WriteLine("Invalid selection."); Console.WriteLine("Press Enter to continue..."); Console.ReadLine(); continue; }
                var chosenOrg = orgs2[sel - 1];
                var contact = PromptContactFields();
                if (contact != null && coordinator.AddContactPerson(chosenOrg.OrganizationId, contact)) Console.WriteLine("Contact added.");
                else Console.WriteLine("Failed to add contact.");
                Console.WriteLine("Press Enter to continue...");
                Console.ReadLine();
            }
            else
            {
                Console.Clear();
                Console.WriteLine("Unknown command. Please choose a menu number or 'b' to go back.");
                Console.WriteLine("Press Enter to continue...");
                Console.ReadLine();
            }
        }
    }

    static ContactPerson? PromptContactFields()
    {
        Console.Write("First name: "); var fn = Console.ReadLine();
        Console.Write("Last name: "); var ln = Console.ReadLine();
        Console.Write("Email: "); var email = Console.ReadLine();
        Console.Write("Job title: "); var job = Console.ReadLine();
        Console.Write("Phone: "); var phone = Console.ReadLine();
        Console.Write("Department: "); var dept = Console.ReadLine();
        var cp = new ContactPerson
        {
            FirstName = string.IsNullOrWhiteSpace(fn) ? null : fn,
            LastName = string.IsNullOrWhiteSpace(ln) ? null : ln,
            Email = string.IsNullOrWhiteSpace(email) ? null : email,
            JobTitle = string.IsNullOrWhiteSpace(job) ? null : job,
            PhoneNumber = string.IsNullOrWhiteSpace(phone) ? null : phone,
            Department = string.IsNullOrWhiteSpace(dept) ? null : dept
        };
        return cp;
    }

    static void PrintContact(ContactPerson cp)
    {
        Console.WriteLine($"  {cp.Id} - {cp.FirstName ?? ""} {cp.LastName ?? ""}");
        Console.WriteLine($"     Email: {cp.Email ?? "-"}  Job: {cp.JobTitle ?? "-"}  Phone: {cp.PhoneNumber ?? "-"}  Dept: {cp.Department ?? "-"}");
    }

    static void AddInternshipPrompt()
    {
        Console.WriteLine();
        var orgs = coordinator.GetOrganizationsOverview().ToList();
        if (!orgs.Any()) { Console.WriteLine("No organizations found. Add an organization first."); return; }

        Console.WriteLine("Select organization:");
        for (int i = 0; i < orgs.Count; i++) Console.WriteLine($"{i+1}. {orgs[i].Name} ({orgs[i].OrganizationId})");
        var sel = Console.ReadLine();
        if (!int.TryParse(sel, out var idx) || idx < 1 || idx > orgs.Count) { Console.WriteLine("Invalid selection."); return; }
        var org = orgs[idx - 1];

        Console.Write("Title: "); var title = Console.ReadLine() ?? "";
        Console.Write("Short description: "); var shortDesc = Console.ReadLine() ?? "";
        Console.Write("Long description: "); var longDesc = Console.ReadLine() ?? "";
        Console.Write("Year: "); var year = int.TryParse(Console.ReadLine(), out var y) ? y : DateTime.Now.Year;
        Console.Write("Semester (1 or 2): "); var sem = int.TryParse(Console.ReadLine(), out var s) ? s : 1;

        Console.WriteLine("Category: 0=Research, 1=Minor, 2=Engineering (enter number)");
        var catInput = Console.ReadLine();
        InternshipCategory category = InternshipCategory.Research;
        if (int.TryParse(catInput, out var cval) && Enum.IsDefined(typeof(InternshipCategory), cval))
            category = (InternshipCategory)cval;

        var internship = new Internship(org.OrganizationId, org.Name, title, shortDesc, longDesc, new Period(year, sem), category);

        Console.Write("Add existing contact(s) from organization to this internship? (y/n): ");
        if (Console.ReadLine()?.ToLower() == "y")
        {
            var contacts = coordinator.GetContactPersonsByOrganization(org.OrganizationId).ToList();
            for (int i = 0; i < contacts.Count; i++) Console.WriteLine($"{i+1}. {contacts[i].FirstName} {contacts[i].LastName} ({contacts[i].Id})");
            Console.WriteLine("Enter comma-separated numbers to add (or blank):");
            var choices = Console.ReadLine();
            if (!string.IsNullOrWhiteSpace(choices))
            {
                foreach (var part in choices.Split(',', StringSplitOptions.RemoveEmptyEntries))
                {
                    if (int.TryParse(part.Trim(), out var n) && n >= 1 && n <= contacts.Count)
                        internship.Contacts.Add(contacts[n - 1]);
                }
            }
        }

        coordinator.AddInternship(internship);
        Console.WriteLine();
        Console.WriteLine($"Added internship {internship.Id}");
    }

    static void AddStudentPrompt()
    {
        Console.WriteLine();
        Console.Write("Student Id: "); var sid = Console.ReadLine();
        if (string.IsNullOrWhiteSpace(sid)) { Console.WriteLine("Id required."); return; }
        Console.Write("First name: "); var fn = Console.ReadLine();
        Console.Write("Last name: "); var ln = Console.ReadLine();
        var student = new Student(sid, fn ?? "", ln ?? "");
        if (coordinator.AddStudent(student)) Console.WriteLine($"Student {student.StudentId} added/updated.");
        else Console.WriteLine("Failed to add student.");
    }

    static void StudentMenu()
    {
        while (true)
        {
            Console.Clear(); // clear before showing student menu
            Console.WriteLine("Student Menu:");
            Console.WriteLine("(1) Browse internships");
            Console.WriteLine("(2) Register");
            Console.WriteLine("(b) Back");
            Console.Write("Choose: ");
            var cmd = Console.ReadLine();
            if (cmd == "b") break;
            if (cmd == "1")
            {
                Console.Clear();
                Console.Write("Year: "); var y = int.Parse(Console.ReadLine() ?? "0");
                Console.Write("Semester: "); var s = int.Parse(Console.ReadLine() ?? "0");
                var list = coordinator.GetInternshipsOverview(new Period(y, s)).ToList();
                Console.Clear();
                var idx = 1;
                foreach (var i in list) Console.WriteLine($"{idx++}. {i.OrganizationName} | {i.Title} | {i.ShortDescription} (Id: {i.Id})");
                Console.WriteLine();
                Console.WriteLine("Enter number to view details or blank to return:");
                var sel = Console.ReadLine();
                if (int.TryParse(sel, out int n) && n > 0 && n <= list.Count)
                {
                    var chosen = list[n - 1];
                    Console.Clear();
                    Console.WriteLine($"Title: {chosen.Title}\nOrganization: {chosen.OrganizationName}\nPeriod: {chosen.Period}\nCategory: {chosen.Category}");
                    Console.WriteLine();
                    Console.WriteLine("Contacts for this internship:");
                    var contacts = coordinator.GetContactPersonsForInternship(chosen.Id).ToList();
                    if (!contacts.Any()) Console.WriteLine("  (no contacts)");
                    else foreach (var c in contacts) PrintContact(c);

                    Console.WriteLine();
                    Console.Write("Enter your student id to apply (blank to cancel): "); var sid = Console.ReadLine();
                    if (string.IsNullOrWhiteSpace(sid)) { Console.WriteLine("Cancelled."); Console.WriteLine("Press Enter to continue..."); Console.ReadLine(); continue; }
                    Console.Write("First name: "); var fn = Console.ReadLine();
                    Console.Write("Last name: "); var ln = Console.ReadLine();
                    var student = new Student(sid, fn ?? "", ln ?? "");
                    if (coordinator.AssignStudentToInternship(student, chosen.Id))
                    {
                        Console.WriteLine("Assigned (provisional). Contact info above for follow-up.");
                        if (contacts.Any())
                        {
                            Console.WriteLine();
                            Console.WriteLine("Contact(s) to reach out to:");
                            foreach (var c in contacts) PrintContact(c);
                        }
                    }
                    else Console.WriteLine("Cannot assign (possibly conflict or duplicate).");

                    Console.WriteLine();
                    Console.WriteLine("Press Enter to continue...");
                    Console.ReadLine();
                }
            }
            else if (cmd == "2")
            {
                Console.Clear();
                AddStudentPrompt();
                Console.WriteLine("Press Enter to continue...");
                Console.ReadLine();
            }
            else
            {
                Console.Clear();
                Console.WriteLine("Unknown command. Please choose a menu number or 'b' to go back.");
                Console.WriteLine("Press Enter to continue...");
                Console.ReadLine();
            }
        }
    }
}


