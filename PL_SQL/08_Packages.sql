-- ==========================================
-- Cybersecurity Training CTF Database
-- File: 08_Packages.sql
-- Description: CTF reporting package
-- Database: Oracle
-- ==========================================

CREATE OR REPLACE PACKAGE CTF_REPORT_PKG AS

    FUNCTION Get_User_Score (
        p_user_id IN Users.User_ID%TYPE
    )
    RETURN NUMBER;

    PROCEDURE Get_User_Submissions (
        p_user_id IN Users.User_ID%TYPE,
        p_result  OUT SYS_REFCURSOR
    );

END CTF_REPORT_PKG;
/

CREATE OR REPLACE PACKAGE BODY CTF_REPORT_PKG AS

    FUNCTION Get_User_Score (
        p_user_id IN Users.User_ID%TYPE
    )
    RETURN NUMBER
    IS
        v_score NUMBER;
    BEGIN
        v_score := Calculate_User_Score(p_user_id);
        RETURN v_score;
    END Get_User_Score;


    PROCEDURE Get_User_Submissions (
        p_user_id IN Users.User_ID%TYPE,
        p_result  OUT SYS_REFCURSOR
    )
    IS
    BEGIN
        OPEN p_result FOR
            SELECT
                S.Submission_ID,
                S.Challenge_ID,
                C.Challenge_Name,
                S.Is_Correct,
                S.Score_Awarded,
                S.Submission_Time
            FROM Submissions S
            INNER JOIN Challenges C
                ON S.Challenge_ID = C.Challenge_ID
            WHERE S.User_ID = p_user_id
            ORDER BY S.Submission_Time;
    END Get_User_Submissions;

END CTF_REPORT_PKG;
/
