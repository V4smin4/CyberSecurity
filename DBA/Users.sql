-- ==========================================
-- Cybersecurity Training CTF Database
-- File: Users.sql (DBA)
-- Description: Database-level user creation and account management
-- Database: Oracle
-- ==========================================
--
-- NOTE:
-- The statements below require the CREATE USER / ALTER USER
-- system privileges, which are normally granted only to a
-- DBA-level account. On restricted/shared sandbox environments
-- (such as a student cloud schema), these statements may fail
-- with ORA-01031: insufficient privileges. They are included
-- here to demonstrate correct DBA practice for user provisioning
-- and would run successfully on a full Oracle instance with a
-- DBA-privileged account.
-- ==========================================


-- ==========================================
-- 1. Create Application-Level Database Users
-- ==========================================
-- Three accounts representing the three platform roles
-- (Admin, Trainer, Player/Viewer), separate from the
-- application-level Users table and Roles table.

-- Passwords below are placeholders only.
-- Replace <ADMIN_PASSWORD> / <TRAINER_PASSWORD> / <VIEWER_PASSWORD>
-- with a real, securely stored password before execution.
-- Never commit literal credentials to a public repository.

CREATE USER CTF_ADMIN
    IDENTIFIED BY "<ADMIN_PASSWORD>"
    DEFAULT TABLESPACE USERS
    TEMPORARY TABLESPACE TEMP
    QUOTA UNLIMITED ON USERS;

CREATE USER CTF_TRAINER
    IDENTIFIED BY "<TRAINER_PASSWORD>"
    DEFAULT TABLESPACE USERS
    TEMPORARY TABLESPACE TEMP
    QUOTA 100M ON USERS;

CREATE USER CTF_VIEWER
    IDENTIFIED BY "<VIEWER_PASSWORD>"
    DEFAULT TABLESPACE USERS
    TEMPORARY TABLESPACE TEMP
    QUOTA 10M ON USERS;


-- ==========================================
-- 2. Account Status Management
-- ==========================================

-- Lock an account (e.g. a trainer on leave)
ALTER USER CTF_TRAINER ACCOUNT LOCK;

-- Unlock the account again
ALTER USER CTF_TRAINER ACCOUNT UNLOCK;

-- Force password expiration (user must change password at next login)
ALTER USER CTF_VIEWER PASSWORD EXPIRE;


-- ==========================================
-- 3. Verify Users (readable without DBA privileges)
-- ==========================================
-- ALL_USERS is a public view and does not require DBA rights.
-- Note: ACCOUNT_STATUS is not a column of ALL_USERS (it exists
-- only in DBA_USERS / USER_USERS, which require higher
-- privileges), so it is intentionally left out here.

SELECT USERNAME,
       CREATED
FROM ALL_USERS
WHERE USERNAME LIKE 'CTF_%'
ORDER BY CREATED DESC;


-- ==========================================
-- 4. Drop a User (cleanup / decommission)
-- ==========================================
-- CASCADE removes any objects owned by the user as well.
-- Commented out by default to avoid accidental execution.

-- DROP USER CTF_VIEWER CASCADE;


-- ==========================================
-- FreeSQL Execution Note
-- ==========================================
-- The current FreeSQL schema does not have
-- database-level user administration privileges.
-- Therefore, CREATE USER and ALTER USER statements
-- are documented above but are not executed in
-- the restricted student environment.
