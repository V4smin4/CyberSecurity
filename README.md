# Cybersecurity Training CTF Database

## Project Overview

This project is a Cybersecurity Training Capture The Flag (CTF) Database
developed using Oracle Database.

The system is designed to manage users, roles, cybersecurity challenges,
teams, submissions, hints, training sessions, attendance, and audit logs.

The project demonstrates practical Oracle SQL, PL/SQL, and DBA concepts
through a structured and maintainable database implementation.

---

## Technologies

- Oracle Database
- Oracle SQL Developer Web / FreeSQL
- SQL
- PL/SQL
- GitHub

---

## Database Tables

The database consists of the following main tables:

- Roles
- Users
- Categories
- Challenges
- Teams
- Team_Members
- Hints
- Submissions
- Training_Sessions
- Session_Attendees
- Audit_Logs

---

## SQL Features

The project demonstrates:

- SELECT
- WHERE
- ORDER BY
- LIKE
- BETWEEN
- IN
- GROUP BY
- HAVING
- JOIN
- Subqueries
- Database Views
- Aggregate Functions
- Filtering and Sorting
- Reporting Queries

---

## PL/SQL Features

The project includes:

- Stored Procedures
- Functions
- Triggers
- Packages

PL/SQL logic is used to implement business rules, validation,
automation, scoring, team assignment, hint management, and reporting.

---

## Database Views

The project includes the following reporting views:

- V_ACTIVE_CHALLENGES
- V_USER_SUBMISSION_SUMMARY

These views provide reusable reporting functionality for active challenges
and user submission performance.

---

## DBA Features

The project demonstrates Oracle DBA concepts including:

- User Management
- Role Management
- Privileges and Grants
- Tablespaces
- Backup and Recovery Documentation
- Performance Optimization
- Indexes
- EXPLAIN PLAN
- DBMS_XPLAN
- DBMS_STATS
- SYS_CONTEXT
- Oracle Data Dictionary Views

---

## Performance Optimization

The project includes performance-related examples such as:

- Index creation
- Query execution plans
- EXPLAIN PLAN analysis
- Table statistics
- Performance-oriented indexing of frequently searched and joined columns

Example indexes include:

- IDX_SUBMISSIONS_USER
- IDX_SUBMISSIONS_CHALLENGE
- IDX_CHALLENGES_CATEGORY
- IDX_TEAM_MEMBERS_TEAM
- IDX_TEAM_MEMBERS_USER

---

## ERD

The project includes an Entity Relationship Diagram (`Documentation/ERD.png`)
describing the database tables and their relationships.

The ERD represents primary keys, foreign keys, and relationships between
the main entities.

---

## Project Structure

```
CyberSecurity/
│
├── SQL/
│   ├── 01_Create_Tables.sql
│   ├── 02_Insert_Data.sql
│   ├── 03_SQL_Queries.sql
│   └── 04_Views.sql
│
├── PL_SQL/
│   ├── 05_Procedures.sql
│   ├── 06_Functions.sql
│   ├── 07_Triggers.sql
│   └── 08_Packages.sql
│
├── DBA/
│   ├── Users.sql
│   ├── Roles.sql
│   ├── Grants.sql
│   ├── Tablespaces.sql
│   ├── Backup.sql
│   └── Performance.sql
│
├── Documentation/
│   ├── Problem_Statement.md
│   ├── Requirements.md
│   ├── Business_Rules.md
│   ├── Data_Dictionary.md
│   └── ERD.png
│
├── Screenshots/
│
└── README.md
```

## About

No description, website, or topics provided.
