-- ==========================================
-- Cybersecurity Training CTF Database
-- File: 06_Functions.sql
-- Description: Calculate total score for a user
-- Database: Oracle
-- ==========================================

CREATE OR REPLACE FUNCTION Calculate_User_Score (
    p_user_id IN Users.User_ID%TYPE
)
RETURN NUMBER
AS
    v_score NUMBER;
BEGIN

    SELECT NVL(SUM(Score_Awarded), 0)
    INTO v_score
    FROM Submissions
    WHERE User_ID = p_user_id;

    RETURN v_score;

EXCEPTION
    WHEN NO_DATA_FOUND THEN
        RETURN 0;
END Calculate_User_Score;
/
