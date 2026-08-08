-- ==========================================
-- Cybersecurity Training CTF Database
-- File: TRG_AUDIT_SUBMISSIONS.sql
-- Description: Audit submission operations
-- Database: Oracle
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
