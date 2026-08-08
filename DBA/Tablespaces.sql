-- ==========================================
-- Cybersecurity Training CTF Database
-- File: Tablespaces.sql (DBA)
-- Description: Tablespace management
-- Database: Oracle
-- ==========================================

-- NOTE:
-- CREATE TABLESPACE and ALTER TABLESPACE statements
-- require DBA-level privileges.
--
-- The current FreeSQL student schema is restricted
-- and does not provide the privileges required to
-- create or modify database tablespaces.
--
-- Therefore, the statements below are documented as
-- DBA configuration examples for deployment on a
-- full Oracle database instance. Datafile paths use a
-- typical Oracle Linux directory layout as an example;
-- adjust to match the target server's actual directory
-- structure before execution.
-- ==========================================


-- ==========================================
-- 1. Create CTF Data Tablespace
-- ==========================================

CREATE TABLESPACE CTF_DATA
DATAFILE '/u01/app/oracle/oradata/ctf_data01.dbf'
SIZE 100M
AUTOEXTEND ON
NEXT 10M
MAXSIZE 500M;


-- ==========================================
-- 2. Create CTF Index Tablespace
-- ==========================================

CREATE TABLESPACE CTF_INDEX
DATAFILE '/u01/app/oracle/oradata/ctf_index01.dbf'
SIZE 50M
AUTOEXTEND ON
NEXT 5M
MAXSIZE 250M;


-- ==========================================
-- 3. Configure Tablespace Storage
-- ==========================================
-- Note: a tablespace is ONLINE by default immediately
-- after CREATE TABLESPACE. These statements are included
-- explicitly for clarity / documentation purposes.

ALTER TABLESPACE CTF_DATA ONLINE;
ALTER TABLESPACE CTF_INDEX ONLINE;


-- ==========================================
-- 4. Set Default Tablespace for CTF Users
-- ==========================================
-- Requires the CTF_ADMIN / CTF_TRAINER / CTF_VIEWER users
-- (Users.sql) and the CTF_DATA tablespace (Section 1 above)
-- to already exist.

ALTER USER CTF_ADMIN
DEFAULT TABLESPACE CTF_DATA;

ALTER USER CTF_TRAINER
DEFAULT TABLESPACE CTF_DATA;

ALTER USER CTF_VIEWER
DEFAULT TABLESPACE CTF_DATA;


-- ==========================================
-- 5. Configure User Quotas
-- ==========================================

ALTER USER CTF_ADMIN
QUOTA UNLIMITED ON CTF_DATA;

ALTER USER CTF_TRAINER
QUOTA 100M ON CTF_DATA;

ALTER USER CTF_VIEWER
QUOTA 20M ON CTF_DATA;


-- ==========================================
-- 6. Verify Tablespaces
-- ==========================================

-- DBA can use this query to check tablespace status.

SELECT TABLESPACE_NAME,
       STATUS,
       CONTENTS
FROM DBA_TABLESPACES
WHERE TABLESPACE_NAME IN ('CTF_DATA', 'CTF_INDEX')
ORDER BY TABLESPACE_NAME;


-- ==========================================
-- 7. Verify Datafiles
-- ==========================================

SELECT TABLESPACE_NAME,
       FILE_NAME,
       BYTES / 1024 / 1024 AS SIZE_MB,
       AUTOEXTENSIBLE
FROM DBA_DATA_FILES
WHERE TABLESPACE_NAME IN ('CTF_DATA', 'CTF_INDEX')
ORDER BY TABLESPACE_NAME, FILE_NAME;


-- ==========================================
-- FreeSQL Execution Note
-- ==========================================

-- The current FreeSQL student schema does not have
-- the DBA privileges required to execute:
--
-- CREATE TABLESPACE
-- ALTER TABLESPACE
-- ALTER USER
--
-- Therefore, Sections 1 through 5 are documented as
-- DBA-level configuration.
--
-- Sections 6 and 7 are verification queries and may
-- require DBA-level access depending on the Oracle
-- environment.
--
-- These statements are intended for execution by an
-- authorized DBA on a full Oracle database instance
