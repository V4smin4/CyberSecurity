-- ==========================================
-- Cybersecurity Training CTF Database
-- File: Grants.sql (DBA)
-- Description: System privilege management
-- Database: Oracle
-- ==========================================

-- NOTE:
-- GRANT statements for system privileges require
-- appropriate DBA/system privileges.
--
-- The current FreeSQL student schema is restricted,
-- so these statements may fail with:
-- ORA-01031: insufficient privileges
--
-- They are included as DBA configuration examples
-- for deployment on a full Oracle database instance.
-- ==========================================


-- ==========================================
-- 1. Grant System Privileges to CTF Roles
-- ==========================================

-- ------------------------------------------
-- Read-Only Role
-- ------------------------------------------

-- Allow the role to create database sessions.
GRANT CREATE SESSION TO CTF_READ_ONLY_ROLE;


-- ------------------------------------------
-- Trainer Role
-- ------------------------------------------

-- Allow trainers to connect to the database.
GRANT CREATE SESSION TO CTF_TRAINER_ROLE;


-- ------------------------------------------
-- Admin Role
-- ------------------------------------------

-- Allow administrators to connect to the database.
GRANT CREATE SESSION TO CTF_ADMIN_ROLE;

-- Allow administrators to create views.
GRANT CREATE VIEW TO CTF_ADMIN_ROLE;

-- Allow administrators to create procedures.
GRANT CREATE PROCEDURE TO CTF_ADMIN_ROLE;

-- Allow administrators to create sequences.
GRANT CREATE SEQUENCE TO CTF_ADMIN_ROLE;


-- ==========================================
-- 2. Grant Additional Database Privileges
-- ==========================================

-- These privileges are examples of controlled
-- administrative capabilities.

-- Allow the admin role to create triggers.
GRANT CREATE TRIGGER TO CTF_ADMIN_ROLE;

-- Allow the admin role to create synonyms.
GRANT CREATE SYNONYM TO CTF_ADMIN_ROLE;


-- ==========================================
-- 3. Verify Granted Privileges
-- ==========================================

-- The following queries can be used by a DBA
-- to verify system privileges.

SELECT GRANTEE,
       PRIVILEGE
FROM DBA_SYS_PRIVS
WHERE GRANTEE IN (
    'CTF_READ_ONLY_ROLE',
    'CTF_TRAINER_ROLE',
    'CTF_ADMIN_ROLE'
)
ORDER BY GRANTEE, PRIVILEGE;


-- ==========================================
-- 4. Verify Role Privileges
-- ==========================================

-- Verify privileges granted through the roles.

SELECT GRANTEE,
       TABLE_NAME,
       PRIVILEGE
FROM DBA_TAB_PRIVS
WHERE GRANTEE IN (
    'CTF_READ_ONLY_ROLE',
    'CTF_TRAINER_ROLE',
    'CTF_ADMIN_ROLE'
)
ORDER BY GRANTEE, TABLE_NAME, PRIVILEGE;


-- ==========================================
-- FreeSQL Execution Note
-- ==========================================

-- The current FreeSQL student schema does not have
-- the DBA privileges required to execute the GRANT
-- statements above.
--
-- Therefore, this file is maintained as DBA-level
-- configuration documentation for the project.
--
-- On a full Oracle database with appropriate DBA
-- privileges, the statements can be executed normally.
--
-- The verification queries using DBA_SYS_PRIVS and
-- DBA_TAB_PRIVS may also require additional privileges
-- depending on the Oracle environment
