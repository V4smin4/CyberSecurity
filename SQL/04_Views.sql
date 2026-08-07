-- ==========================================
-- Cybersecurity Training CTF Database
-- File: 04_Views.sql
-- Description: Database Views
-- Database: Oracle
-- ==========================================


-- ==========================================
-- 1. View: User Information
-- ==========================================
-- Displays users together with their role names.

CREATE OR REPLACE VIEW VW_USER_INFORMATION AS
SELECT
    U.User_ID,
    U.Full_Name,
    U.Email,
    R.Role_Name,
    U.Registration_Date,
    U.Last_Login,
    U.Status,
    U.Failed_Attempts,
    U.Account_Locked
FROM Users U
INNER JOIN Roles R
    ON U.Role_ID = R.Role_ID;


-- ==========================================
-- 2. View: Active Users
-- ==========================================
-- Displays only active users.

CREATE OR REPLACE VIEW VW_ACTIVE_USERS AS
SELECT
    User_ID,
    Full_Name,
    Email,
    Role_ID,
    Registration_Date,
    Last_Login
FROM Users
WHERE Status = 'Active';


-- ==========================================
-- 3. View: Active Challenges
-- ==========================================
-- Displays active challenges with category information.

CREATE OR REPLACE VIEW VW_ACTIVE_CHALLENGES AS
SELECT
    C.Challenge_ID,
    C.Challenge_Name,
    C.Description,
    C.Points,
    CAT.Category_Name,
    C.Max_Attempts,
    C.Created_Date,
    C.Status
FROM Challenges C
INNER JOIN Categories CAT
    ON C.Category_ID = CAT.Category_ID
WHERE C.Status = 'Active';


-- ==========================================
-- 4. View: Challenge Statistics
-- ==========================================
-- Displays the number of submissions and
-- correct submissions for each challenge.

CREATE OR REPLACE VIEW VW_CHALLENGE_STATISTICS AS
SELECT
    C.Challenge_ID,
    C.Challenge_Name,
    C.Points,
    CAT.Category_Name,
    COUNT(S.Submission_ID) AS Total_Submissions,
    SUM(
        CASE
            WHEN S.Is_Correct = 'Y' THEN 1
            ELSE 0
        END
    ) AS Correct_Submissions,
    NVL(SUM(S.Score_Awarded), 0) AS Total_Score_Awarded
FROM Challenges C
INNER JOIN Categories CAT
    ON C.Category_ID = CAT.Category_ID
LEFT JOIN Submissions S
    ON C.Challenge_ID = S.Challenge_ID
GROUP BY
    C.Challenge_ID,
    C.Challenge_Name,
    C.Points,
    CAT.Category_Name;


-- ==========================================
-- 5. View: Top Players
-- ==========================================
-- Calculates the total score for each user.

CREATE OR REPLACE VIEW VW_TOP_PLAYERS AS
SELECT
    U.User_ID,
    U.Full_Name,
    NVL(SUM(S.Score_Awarded), 0) AS Total_Score,
    COUNT(
        CASE
            WHEN S.Is_Correct = 'Y' THEN 1
        END
    ) AS Solved_Challenges,
    COUNT(S.Submission_ID) AS Total_Submissions
FROM Users U
LEFT JOIN Submissions S
    ON U.User_ID = S.User_ID
GROUP BY
    U.User_ID,
    U.Full_Name;


-- ==========================================
-- 6. View: Team Members
-- ==========================================
-- Displays teams, leaders and their members.

CREATE OR REPLACE VIEW VW_TEAM_MEMBERS AS
SELECT
    T.Team_ID,
    T.Team_Name,
    T.Leader_ID,
    L.Full_Name AS Leader_Name,
    U.User_ID AS Member_ID,
    U.Full_Name AS Member_Name,
    TM.Join_Date
FROM Teams T
INNER JOIN Users L
    ON T.Leader_ID = L.User_ID
INNER JOIN Team_Members TM
    ON T.Team_ID = TM.Team_ID
INNER JOIN Users U
    ON TM.User_ID = U.User_ID;


-- ==========================================
-- 7. View: Team Statistics
-- ==========================================
-- Displays the number of members and
-- total score earned by each team.

CREATE OR REPLACE VIEW VW_TEAM_STATISTICS AS
SELECT
    T.Team_ID,
    T.Team_Name,
    L.Full_Name AS Leader_Name,
    COUNT(DISTINCT TM.User_ID) AS Member_Count,
    NVL(SUM(S.Score_Awarded), 0) AS Team_Total_Score
FROM Teams T
INNER JOIN Users L
    ON T.Leader_ID = L.User_ID
LEFT JOIN Team_Members TM
    ON T.Team_ID = TM.Team_ID
LEFT JOIN Submissions S
    ON TM.User_ID = S.User_ID
GROUP BY
    T.Team_ID,
    T.Team_Name,
    L.Full_Name;


-- ==========================================
-- 8. View: Training Sessions
-- ==========================================
-- Displays training sessions with trainer names.

CREATE OR REPLACE VIEW VW_TRAINING_SESSIONS AS
SELECT
    TS.Session_ID,
    TS.Session_Name,
    TS.Description,
    U.Full_Name AS Trainer_Name,
    TS.Session_Date,
    TS.Duration_Minutes
FROM Training_Sessions TS
INNER JOIN Users U
    ON TS.Trainer_ID = U.User_ID;


-- ==========================================
-- 9. View: Training Progress
-- ==========================================
-- Displays attendance information for
-- users participating in training sessions.

CREATE OR REPLACE VIEW VW_TRAINING_PROGRESS AS
SELECT
    U.User_ID,
    U.Full_Name,
    TS.Session_ID,
    TS.Session_Name,
    TS.Session_Date,
    SA.Attendance_Status
FROM Session_Attendees SA
INNER JOIN Users U
    ON SA.User_ID = U.User_ID
INNER JOIN Training_Sessions TS
    ON SA.Session_ID = TS.Session_ID;


-- ==========================================
-- 10. View: Hints Information
-- ==========================================
-- Displays hints together with challenge names.

CREATE OR REPLACE VIEW VW_HINTS_INFORMATION AS
SELECT
    H.Hint_ID,
    C.Challenge_ID,
    C.Challenge_Name,
    H.Hint_Text,
    H.Points_Cost
FROM Hints H
INNER JOIN Challenges C
    ON H.Challenge_ID = C.Challenge_ID;


-- ==========================================
-- 11. View: Audit Log Report
-- ==========================================
-- Displays audit logs together with
-- the user who performed the action.

CREATE OR REPLACE VIEW VW_AUDIT_LOG_REPORT AS
SELECT
    A.Log_ID,
    A.User_ID,
    U.Full_Name,
    A.Action,
    A.Action_Date,
    A.IP_Address,
    A.Description
FROM Audit_Logs A
LEFT JOIN Users U
    ON A.User_ID = U.User_ID;


-- ==========================================
-- 12. View: User Submission Report
-- ==========================================
-- Displays submission details for each user.

CREATE OR REPLACE VIEW VW_USER_SUBMISSION_REPORT AS
SELECT
    S.Submission_ID,
    U.User_ID,
    U.Full_Name,
    C.Challenge_ID,
    C.Challenge_Name,
    C.Points AS Challenge_Points,
    S.Is_Correct,
    S.Submission_Time,
    S.IP_Address,
    S.Score_Awarded
FROM Submissions S
INNER JOIN Users U
    ON S.User_ID = U.User_ID
INNER JOIN Challenges C
    ON S.Challenge_ID = C.Challenge_ID;


-- ==========================================
-- 13. View: Category Statistics
-- ==========================================
-- Displays the number of challenges
-- and total points for each category.

CREATE OR REPLACE VIEW VW_CATEGORY_STATISTICS AS
SELECT
    CAT.Category_ID,
    CAT.Category_Name,
    COUNT(C.Challenge_ID) AS Challenge_Count,
    NVL(SUM(C.Points), 0) AS Total_Points,
    NVL(AVG(C.Points), 0) AS Average_Points
FROM Categories CAT
LEFT JOIN Challenges C
    ON CAT.Category_ID = C.Category_ID
GROUP BY
    CAT.Category_ID,
    CAT.Category_Name;


-- ==========================================
-- 14. View: Correct Submissions
-- ==========================================
-- Displays only successful challenge submissions.

CREATE OR REPLACE VIEW VW_CORRECT_SUBMISSIONS AS
SELECT
    S.Submission_ID,
    U.Full_Name,
    C.Challenge_Name,
    S.Submission_Time,
    S.Score_Awarded
FROM Submissions S
INNER JOIN Users U
    ON S.User_ID = U.User_ID
INNER JOIN Challenges C
    ON S.Challenge_ID = C.Challenge_ID
WHERE S.Is_Correct = 'Y';


-- ==========================================
-- 15. View: Challenge Creators
-- ==========================================
-- Displays challenges together with
-- their creators.

CREATE OR REPLACE VIEW VW_CHALLENGE_CREATORS AS
SELECT
    C.Challenge_ID,
    C.Challenge_Name,
    U.User_ID AS Creator_ID,
    U.Full_Name AS Creator_Name,
    R.Role_Name AS Creator_Role
FROM Challenges C
INNER JOIN Users U
    ON C.Created_By = U.User_ID
INNER JOIN Roles R
    ON U.Role_ID = R.Role_ID;


-- ==========================================
-- End of 04_Views.sql
-- ==========================================
