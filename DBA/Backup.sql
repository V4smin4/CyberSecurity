-- ==========================================
-- Cybersecurity Training CTF Database
-- File: Backup.sql (DBA)
-- Description: Oracle backup and recovery plan (RMAN)
-- Database: Oracle
-- ==========================================
--
-- IMPORTANT -- READ BEFORE USE:
-- The commands below are RMAN (Recovery Manager) commands,
-- NOT SQL statements. RMAN has its own command language that
-- is completely separate from SQL/PL-SQL.
--
-- These commands cannot be run inside a SQL Worksheet or
-- SQL*Plus session. They must be executed from a dedicated
-- RMAN prompt, normally started from a terminal using:
--
--     rman target /
--
-- This is different from the other DBA files
-- (Users.sql, Roles.sql, Grants.sql, Tablespaces.sql).
-- Those files contain valid Oracle SQL statements but may
-- require DBA privileges.
--
-- RMAN commands belong to the Oracle Recovery Manager utility
-- and are documented here as part of the project's backup
-- and recovery strategy.
-- ==========================================


-- ==========================================
-- 1. Full Database Backup
-- ==========================================
-- Run from a terminal:
--
--     rman target /
--
-- Then execute at the RMAN> prompt:

BACKUP DATABASE
FORMAT '/backup/ctf_db_%U.bkp';


-- ==========================================
-- 2. Backup Database with Archive Logs
-- ==========================================
-- Backs up the database together with archived redo logs.
-- This supports point-in-time recovery.

BACKUP DATABASE PLUS ARCHIVELOG
FORMAT '/backup/ctf_full_%U.bkp';


-- ==========================================
-- 3. Backup Control File
-- ==========================================
-- The control file contains important database structure
-- and metadata.

BACKUP CURRENT CONTROLFILE
FORMAT '/backup/ctf_control_%U.bkp';


-- ==========================================
-- 4. Backup SPFILE
-- ==========================================
-- Backs up the Oracle server parameter file.

BACKUP SPFILE
FORMAT '/backup/ctf_spfile_%U.bkp';


-- ==========================================
-- 5. Validate Backup
-- ==========================================
-- Validates whether the database can be restored
-- without actually performing the restore.

RESTORE DATABASE VALIDATE;


-- ==========================================
-- 6. List Available Backups
-- ==========================================
-- Displays a summary of available RMAN backups.

LIST BACKUP SUMMARY;


-- ==========================================
-- 7. Database Recovery Example
-- ==========================================
-- Typical recovery sequence after a database failure.

STARTUP MOUNT;

RESTORE DATABASE;

RECOVER DATABASE;

ALTER DATABASE OPEN;


-- ==========================================
-- 8. Backup Retention Policy
-- ==========================================
-- Keeps enough backups to recover the database
-- to any point within the last seven days.

CONFIGURE RETENTION POLICY
TO RECOVERY WINDOW OF 7 DAYS;


-- ==========================================
-- 9. Delete Obsolete Backups
-- ==========================================
-- Removes backups that are no longer required
-- according to the configured retention policy.
--
-- Run only after confirming that the backups are
-- no longer required for recovery.

DELETE OBSOLETE;


-- ==========================================
-- 10. Cold Backup
-- ==========================================
-- A cold backup is performed while the database
-- is shut down cleanly.
--
-- Example procedure:
--
-- 1. Shut down the database:
--
--     SHUTDOWN IMMEDIATE;
--
-- 2. Copy the database datafiles, control files,
--    and required configuration files to backup storage.
--
-- 3. Start the database again:
--
--     STARTUP;
--
-- Cold backups provide a consistent database copy
-- because the database is not active during the backup.


-- ==========================================
-- 11. Hot Backup
-- ==========================================
-- A hot backup is performed while the database
-- remains available to users.
--
-- In Oracle, RMAN is commonly used to perform
-- online database backups.
--
-- Example:
--
--     BACKUP DATABASE PLUS ARCHIVELOG
--     FORMAT '/backup/ctf_hot_%U.bkp';
--
-- Archived redo logs are important because they
-- allow changes made during the online backup
-- to be applied during recovery.


-- ==========================================
-- 12. Oracle Data Pump Export
-- ==========================================
-- Data Pump can be used for logical export of
-- database objects and data.
--
-- Example command from an operating-system terminal:
--
--     expdp username/password
--     DIRECTORY=DATA_PUMP_DIR
--     DUMPFILE=ctf_database.dmp
--     LOGFILE=ctf_database_export.log
--
-- Data Pump export is different from an RMAN
-- physical database backup.


-- ==========================================
-- 13. Oracle Data Pump Import
-- ==========================================
-- Data Pump import restores objects and data
-- from a Data Pump dump file.
--
-- Example command:
--
--     impdp username/password
--     DIRECTORY=DATA_PUMP_DIR
--     DUMPFILE=ctf_database.dmp
--     LOGFILE=ctf_database_import.log


-- ==========================================
-- 14. Backup Strategy Summary
-- ==========================================
--
-- The project backup strategy includes:
--
-- 1. Full database backup using RMAN.
-- 2. Archive log backup for recovery support.
-- 3. Control file backup.
-- 4. SPFILE backup.
-- 5. Backup validation.
-- 6. Backup listing and monitoring.
-- 7. Database recovery procedure.
-- 8. Seven-day recovery window.
-- 9. Obsolete backup cleanup.
-- 10. Cold backup concept.
-- 11. Hot backup concept.
-- 12. Oracle Data Pump export.
-- 13. Oracle Data Pump import.
--
-- RMAN provides physical backup and recovery,
-- while Data Pump provides logical export/import.


-- ==========================================
-- FreeSQL Execution Note
-- ==========================================
--
-- IMPORTANT:
-- None of the RMAN commands in this file should be
-- executed inside the FreeSQL SQL Worksheet.
--
-- RMAN commands require:
--
--     1. Oracle Recovery Manager (RMAN)
--     2. Access to an Oracle database instance
--     3. Appropriate DBA privileges
--     4. A valid backup destination
--
-- Cold/hot backup operations and Data Pump operations
-- also require access to the Oracle server environment
-- and appropriate privileges.
--
-- The current FreeSQL student schema is restricted and
-- does not provide the required environment for these
-- database-level backup operations.
--
-- Therefore, this file is maintained as DBA-level
-- backup and recovery documentation for the project.
--
-- On a full Oracle database environment, an authorized
-- DBA can execute the appropriate backup, recovery,
-- RMAN, and Data Pump commands.
