# Cybersecurity Training CTF Database

## 1. Problem Statement

Cybersecurity Capture The Flag (CTF) platforms require an organized system
for managing users, teams, cybersecurity challenges, submissions, training
sessions, hints, and scoring.

Without a centralized database, it becomes difficult to:

- Manage users and their roles.
- Organize cybersecurity challenges by category.
- Track user submissions and attempts.
- Calculate and monitor user scores.
- Manage teams and team members.
- Organize cybersecurity training sessions.
- Track session attendees.
- Provide hints for challenges.
- Maintain an audit trail of important activities.
- Generate reports about user performance and challenge activity.

This project addresses these requirements by designing and implementing an
Oracle relational database for a Cybersecurity Training CTF platform.

---

## 2. Proposed Solution

The proposed system uses an Oracle relational database to store and manage
the main entities of the CTF training platform.

The database includes tables for:

- Users
- Roles
- Categories
- Challenges
- Teams
- Team Members
- Hints
- Submissions
- Training Sessions
- Session Attendees
- Audit Logs

The system also includes SQL queries, database views, PL/SQL procedures,
functions, triggers, packages, and DBA configuration documentation.

---

## 3. Main Objectives

The main objectives of the project are:

1. Design a normalized relational database for a cybersecurity CTF platform.
2. Define relationships between users, challenges, teams, and submissions.
3. Enforce data integrity using primary keys, foreign keys, constraints,
   and validation rules.
4. Track challenge submissions and awarded scores.
5. Support team-based cybersecurity training activities.
6. Provide reporting capabilities through SQL queries and views.
7. Automate database operations using PL/SQL.
8. Maintain an audit trail for important database activities.
9. Demonstrate Oracle DBA concepts including users, roles, privileges,
   tablespaces, backup, and performance optimization.
10. Provide a structured and maintainable database project suitable for
    cybersecurity training environments.

---

## 4. Scope

The project covers the database layer of a Cybersecurity Training CTF
platform.

### Included

- Database schema design.
- Table creation.
- Data insertion.
- SQL queries.
- Database views.
- PL/SQL procedures.
- PL/SQL functions.
- PL/SQL triggers.
- PL/SQL packages.
- Audit logging.
- Database performance examples.
- DBA configuration examples.
- Backup and recovery documentation.

### Not Included

The project does not implement a complete web or mobile application.
The database is designed to provide the backend data management layer that
could be used by such an application.

---

## 5. Expected Benefits

The database provides:

- Centralized cybersecurity training data management.
- Reliable tracking of challenge submissions.
- Automatic score calculation.
- Better organization of teams and training sessions.
- Improved data integrity.
- Auditing of important operations.
- Reusable reporting functionality.
- Demonstration of Oracle SQL, PL/SQL, and DBA concepts.

---

## 6. Technology

The project is implemented using:

- Oracle Database
- SQL
- PL/SQL
- Oracle Views
- Oracle Triggers
- Oracle Procedures
- Oracle Functions
- Oracle Packages
- Oracle RMAN documentation
- GitHub for project version control
