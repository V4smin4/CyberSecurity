-- ==========================================
-- Cybersecurity Training CTF Database
-- File: 07_Triggers.sql
-- Description: Database Triggers
-- Database: Oracle
-- ==========================================


-- ==========================================
-- 1. Audit Submissions
-- ==========================================

CREATE OR REPLACE TRIGGER TRG_AUDIT_SUBMISSIONS
AFTER INSERT ON Submissions
FOR EACH ROW
BEGIN

    INSERT INTO Audit_Logs (
        Log_ID,
        User_ID,
        Action,
        Action_Date,
        IP_Address,
        Description
    )
    VALUES (
        (SELECT NVL(MAX(Log_ID), 0) + 1 FROM Audit_Logs),
        :NEW.User_ID,
        'SUBMISSION',
        SYSDATE,
        :NEW.IP_Address,
        'New submission for Challenge ID: '
        || :NEW.Challenge_ID
        || ', Correct: '
        || :NEW.Is_Correct
        || ', Score: '
        || :NEW.Score_Awarded
    );

END;
/


-- ==========================================
-- 2. Automatically Manage Challenge Dates
-- ==========================================

CREATE OR REPLACE TRIGGER TRG_CHALLENGES_DATES
BEFORE INSERT OR UPDATE ON Challenges
FOR EACH ROW
BEGIN

    -- Set creation date automatically for new challenges
    IF INSERTING THEN
        IF :NEW.Created_Date IS NULL THEN
            :NEW.Created_Date := SYSDATE;
        END IF;
    END IF;

    -- Update modification date automatically
    IF UPDATING THEN
        :NEW.Updated_Date := SYSDATE;
    END IF;

END;
/
