-- ==========================================
-- Cybersecurity Training CTF Database
-- File: Roles.sql (DBA)
-- Description: Database role management
-- Database: Oracle
-- ==========================================

-- NOTE:
-- CREATE ROLE and GRANT statements require appropriate
-- DBA/system privileges.
--
-- The current FreeSQL student schema does not provide
-- CREATE ROLE privileges. Therefore, Sections 1, 2, and 3
-- are documented as DBA configuration examples and are
-- not expected to execute in the restricted environment.
--
-- These statements can be executed by an authorized DBA
-- on a full Oracle database instance.
--
-- Naming note:
-- Role names use the "_ROLE" suffix to avoid conflicts
-- with database usernames defined in Users.sql.
-- Oracle users and roles share the same namespace.
-- ==========================================


-- ==========================================
-- 1. Create Database Roles
-- ==========================================

-- Read-only access to the CTF database
CREATE ROLE CTF_READ_ONLY_ROLE;

-- Read/write access for trainers
CREATE ROLE CTF_TRAINER_ROLE;

-- Administrative access for CTF database management
CREATE ROLE CTF_ADMIN_ROLE;


-- ==========================================
-- 2. Grant Object Privileges
-- ==========================================

-- ------------------------------------------
-- Read-only Role
-- ------------------------------------------

GRANT SELECT ON Users TO CTF_READ_ONLY_ROLE;
GRANT SELECT ON Roles TO CTF_READ_ONLY_ROLE;
GRANT SELECT ON Categories TO CTF_READ_ONLY_ROLE;
GRANT SELECT ON Challenges TO CTF_READ_ONLY_ROLE;
GRANT SELECT ON Teams TO CTF_READ_ONLY_ROLE;
GRANT SELECT ON Team_Members TO CTF_READ_ONLY_ROLE;
GRANT SELECT ON Hints TO CTF_READ_ONLY_ROLE;
GRANT SELECT ON Submissions TO CTF_READ_ONLY_ROLE;
GRANT SELECT ON Training_Sessions TO CTF_READ_ONLY_ROLE;
GRANT SELECT ON Session_Attendees TO CTF_READ_ONLY_ROLE;
GRANT SELECT ON Audit_Logs TO CTF_READ_ONLY_ROLE;


-- ------------------------------------------
-- Trainer Role
-- ------------------------------------------

GRANT SELECT, INSERT, UPDATE
ON Challenges TO CTF_TRAINER_ROLE;

GRANT SELECT, INSERT, UPDATE
ON Hints TO CTF_TRAINER_ROLE;

GRANT SELECT, INSERT, UPDATE
ON Training_Sessions TO CTF_TRAINER_ROLE;

GRANT SELECT, INSERT, UPDATE
ON Session_Attendees TO CTF_TRAINER_ROLE;


-- ------------------------------------------
-- Admin Role
-- ------------------------------------------

GRANT SELECT, INSERT, UPDATE, DELETE
ON Users TO CTF_ADMIN_ROLE;

GRANT SELECT, INSERT, UPDATE, DELETE
ON Roles TO CTF_ADMIN_ROLE;

GRANT SELECT, INSERT, UPDATE, DELETE
ON Categories TO CTF_ADMIN_ROLE;

GRANT SELECT, INSERT, UPDATE, DELETE
ON Challenges TO CTF_ADMIN_ROLE;

GRANT SELECT, INSERT, UPDATE, DELETE
ON Teams TO CTF_ADMIN_ROLE;

GRANT SELECT, INSERT, UPDATE, DELETE
ON Team_Members TO CTF_ADMIN_ROLE;

GRANT SELECT, INSERT, UPDATE, DELETE
ON Hints TO CTF_ADMIN_ROLE;

GRANT SELECT, INSERT, UPDATE, DELETE
ON Submissions TO CTF_ADMIN_ROLE;

GRANT SELECT, INSERT, UPDATE, DELETE
ON Training_Sessions TO CTF_ADMIN_ROLE;

GRANT SELECT, INSERT, UPDATE, DELETE
ON Session_Attendees TO CTF_ADMIN_ROLE;

GRANT SELECT, INSERT, UPDATE, DELETE
ON Audit_Logs TO CTF_ADMIN_ROLE;


-- ==========================================
-- 3. Grant Roles to Database Users
-- ==========================================

-- Requires the database users created in Users.sql.

GRANT CTF_READ_ONLY_ROLE TO CTF_VIEWER;
GRANT CTF_TRAINER_ROLE TO CTF_TRAINER;
GRANT CTF_ADMIN_ROLE TO CTF_ADMIN;


-- ==========================================
-- 4. Verify Roles
-- ==========================================

-- This query is safe to execute in the current
-- FreeSQL environment.

SELECT GRANTED_ROLE
FROM USER_ROLE_PRIVS
ORDER BY GRANTED_ROLE;


-- ==========================================
-- FreeSQL Execution Note
-- ==========================================

-- The current FreeSQL student schema does not have
-- CREATE ROLE privileges.
--
-- Therefore:
-- Sections 1, 2, and 3 are DBA-level documentation.
-- Section 4 can be executed to inspect roles granted
-- to the current database session.
--
-- On a full Oracle database with DBA privileges,
-- Sections 1, 2, and 3 can be executed normally
