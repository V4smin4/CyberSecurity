-- ==========================================
-- Cybersecurity Training CTF Database
-- File: Performance.sql (DBA)
-- Description: Database performance analysis and optimization
-- Database: Oracle
-- ==========================================

-- IMPORTANT:
-- This file contains Oracle performance-analysis commands,
-- execution-plan analysis, indexes, and statistics management.
--
-- The EXPLAIN PLAN, CREATE INDEX, DBMS_STATS, and USER_* views
-- used here are applicable to objects owned by the current schema.
--
-- Some DBA-level performance commands may require additional
-- privileges on a full Oracle database.
--
-- FreeSQL Note:
-- The execution-plan and index sections were tested successfully
-- in the student schema.
-- ==========================================


-- ==========================================
-- 1. Execution Plan - User Score
-- ==========================================

EXPLAIN PLAN FOR
SELECT NVL(SUM(Score_Awarded), 0) AS Total_Score
FROM Submissions
WHERE User_ID = 3;

SELECT *
FROM TABLE(DBMS_XPLAN.DISPLAY);


-- ==========================================
-- 2. Execution Plan - User Submissions
-- ==========================================

EXPLAIN PLAN FOR
SELECT S.Submission_ID,
       S.Challenge_ID,
       C.Challenge_Name,
       S.Is_Correct,
       S.Score_Awarded,
       S.Submission_Time
FROM Submissions S
INNER JOIN Challenges C
    ON S.Challenge_ID = C.Challenge_ID
WHERE S.User_ID = 3
ORDER BY S.Submission_Time;

SELECT *
FROM TABLE(DBMS_XPLAN.DISPLAY);


-- ==========================================
-- 3. Execution Plan - Challenges by Category
-- ==========================================

EXPLAIN PLAN FOR
SELECT Challenge_ID,
       Challenge_Name,
       Points,
       Category_ID
FROM Challenges
WHERE Category_ID = 1
ORDER BY Points DESC;

SELECT *
FROM TABLE(DBMS_XPLAN.DISPLAY);


-- ==========================================
-- 4. Execution Plan - Team Members
-- ==========================================

EXPLAIN PLAN FOR
SELECT T.Team_Name,
       U.User_ID,
       U.Full_Name
FROM Teams T
INNER JOIN Team_Members TM
    ON T.Team_ID = TM.Team_ID
INNER JOIN Users U
    ON TM.User_ID = U.User_ID
ORDER BY T.Team_Name, U.Full_Name;

SELECT *
FROM TABLE(DBMS_XPLAN.DISPLAY);


-- ==========================================
-- 5. Performance Indexes
-- ==========================================

-- Speeds up searches and aggregations by User_ID
CREATE INDEX IDX_SUBMISSIONS_USER
ON Submissions (User_ID);


-- Speeds up joins between Submissions and Challenges
CREATE INDEX IDX_SUBMISSIONS_CHALLENGE
ON Submissions (Challenge_ID);


-- Speeds up filtering Challenges by Category_ID
CREATE INDEX IDX_CHALLENGES_CATEGORY
ON Challenges (Category_ID);


-- Speeds up searches for Team_Members by User_ID
CREATE INDEX IDX_TEAM_MEMBERS_USER
ON Team_Members (User_ID);


-- Optional explicit index on Team_ID.
-- Note: Team_Members already has a composite primary key
-- (Team_ID, User_ID), so Oracle normally has an index
-- beginning with Team_ID. This index is retained only
-- as an explicit performance demonstration.
CREATE INDEX IDX_TEAM_MEMBERS_TEAM
ON Team_Members (Team_ID);


-- ==========================================
-- 6. Gather Table Statistics
-- ==========================================

BEGIN
    DBMS_STATS.GATHER_TABLE_STATS(
        OWNNAME => USER,
        TABNAME => 'SUBMISSIONS'
    );

    DBMS_STATS.GATHER_TABLE_STATS(
        OWNNAME => USER,
        TABNAME => 'CHALLENGES'
    );

    DBMS_STATS.GATHER_TABLE_STATS(
        OWNNAME => USER,
        TABNAME => 'TEAM_MEMBERS'
    );
END;
/


-- ==========================================
-- 7. Verify Created Indexes
-- ==========================================

SELECT INDEX_NAME,
       TABLE_NAME,
       STATUS,
       UNIQUENESS
FROM USER_INDEXES
WHERE INDEX_NAME IN (
    'IDX_SUBMISSIONS_USER',
    'IDX_SUBMISSIONS_CHALLENGE',
    'IDX_CHALLENGES_CATEGORY',
    'IDX_TEAM_MEMBERS_USER',
    'IDX_TEAM_MEMBERS_TEAM'
)
ORDER BY INDEX_NAME;


-- ==========================================
-- 8. Verify Index Columns
-- ==========================================

SELECT INDEX_NAME,
       TABLE_NAME,
       COLUMN_NAME,
       COLUMN_POSITION
FROM USER_IND_COLUMNS
WHERE INDEX_NAME IN (
    'IDX_SUBMISSIONS_USER',
    'IDX_SUBMISSIONS_CHALLENGE',
    'IDX_CHALLENGES_CATEGORY',
    'IDX_TEAM_MEMBERS_USER',
    'IDX_TEAM_MEMBERS_TEAM'
)
ORDER BY INDEX_NAME, COLUMN_POSITION;


-- ==========================================
-- 9. Verify Table Statistics
-- ==========================================

SELECT TABLE_NAME,
       NUM_ROWS,
       BLOCKS,
       LAST_ANALYZED
FROM USER_TAB_STATISTICS
WHERE TABLE_NAME IN (
    'SUBMISSIONS',
    'CHALLENGES',
    'TEAM_MEMBERS'
)
ORDER BY TABLE_NAME;


-- ==========================================
-- 10. Re-check User Score Query After Indexing
-- ==========================================

EXPLAIN PLAN FOR
SELECT NVL(SUM(Score_Awarded), 0) AS Total_Score
FROM Submissions
WHERE User_ID = 3;

SELECT *
FROM TABLE(DBMS_XPLAN.DISPLAY);


-- ==========================================
-- 11. Performance Summary
-- ==========================================

-- The indexes created above target the most relevant
-- filtering and JOIN columns used by the project queries:
--
-- 1. Submissions(User_ID)
-- 2. Submissions(Challenge_ID)
-- 3. Challenges(Category_ID)
-- 4. Team_Members(User_ID)
-- 5. Team_Members(Team_ID)
--
-- Execution plans can be compared before and after indexing
-- to evaluate whether Oracle chooses the new indexes.
--
-- A FULL TABLE SCAN is not necessarily a performance problem
-- for small tables. Oracle may correctly choose it when the
-- cost of using an index is higher than scanning the table.
-- ==========================================


-- ==========================================
-- FreeSQL Execution Note
-- ==========================================

-- The EXPLAIN PLAN, CREATE INDEX, USER_INDEXES,
-- USER_IND_COLUMNS, USER_TAB_STATISTICS, and DBMS_STATS
-- sections are intended for objects owned by the current schema.
--
-- DBA-only monitoring features such as DBA_HIST_*,
-- V$ performance views, or ALTER SYSTEM commands may require
-- additional privileges and are intentionally not included.
--
-- This file documents practical Oracle performance analysis
-- and optimization techniques for the Cybersecurity Training
-- CTF Database project.
-- =========================================
