-- ==========================================
-- Cybersecurity Training CTF Database
-- File: 03_SQL_Queries.sql
-- Description: SQL Queries and Reports
-- Database: Oracle
-- ==========================================


-- ==========================================
-- 1. Basic SELECT Queries
-- ==========================================

-- Display all users
SELECT *
FROM Users;


-- Display selected user information
SELECT User_ID,
       Full_Name,
       Email,
       Status
FROM Users;


-- Display all challenges
SELECT Challenge_ID,
       Challenge_Name,
       Points,
       Status
FROM Challenges;


-- Display all training sessions
SELECT Session_ID,
       Session_Name,
       Session_Date,
       Duration_Minutes
FROM Training_Sessions;



-- ==========================================
-- 2. WHERE Clause
-- ==========================================

-- Display active users
SELECT User_ID,
       Full_Name,
       Email
FROM Users
WHERE Status = 'Active';


-- Display users with Admin role
SELECT User_ID,
       Full_Name,
       Email
FROM Users
WHERE Role_ID = 1;


-- Display challenges worth more than 150 points
SELECT Challenge_ID,
       Challenge_Name,
       Points
FROM Challenges
WHERE Points > 150;


-- Display challenges with maximum attempts greater than 2
SELECT Challenge_ID,
       Challenge_Name,
       Max_Attempts
FROM Challenges
WHERE Max_Attempts > 2;



-- ==========================================
-- 3. ORDER BY
-- ==========================================

-- Sort users alphabetically
SELECT User_ID,
       Full_Name,
       Email
FROM Users
ORDER BY Full_Name ASC;


-- Sort challenges by points descending
SELECT Challenge_ID,
       Challenge_Name,
       Points
FROM Challenges
ORDER BY Points DESC;


-- Sort training sessions by date
SELECT Session_ID,
       Session_Name,
       Session_Date
FROM Training_Sessions
ORDER BY Session_Date ASC;



-- ==========================================
-- 4. DISTINCT
-- ==========================================

-- Display distinct user statuses
SELECT DISTINCT Status
FROM Users;


-- Display distinct challenge categories
SELECT DISTINCT Category_ID
FROM Challenges;



-- ==========================================
-- 5. Aggregate Functions
-- ==========================================

-- Count all users
SELECT COUNT(*) AS Total_Users
FROM Users;


-- Count all challenges
SELECT COUNT(*) AS Total_Challenges
FROM Challenges;


-- Calculate total challenge points
SELECT SUM(Points) AS Total_Points
FROM Challenges;


-- Calculate average challenge points
SELECT AVG(Points) AS Average_Points
FROM Challenges;


-- Find highest challenge points
SELECT MAX(Points) AS Highest_Points
FROM Challenges;


-- Find lowest challenge points
SELECT MIN(Points) AS Lowest_Points
FROM Challenges;



-- ==========================================
-- 6. GROUP BY
-- ==========================================

-- Count users by role
SELECT Role_ID,
       COUNT(*) AS User_Count
FROM Users
GROUP BY Role_ID
ORDER BY Role_ID;


-- Count challenges by category
SELECT Category_ID,
       COUNT(*) AS Challenge_Count
FROM Challenges
GROUP BY Category_ID
ORDER BY Category_ID;


-- Count submissions by correctness
SELECT Is_Correct,
       COUNT(*) AS Submission_Count
FROM Submissions
GROUP BY Is_Correct;



-- ==========================================
-- 7. HAVING
-- ==========================================

-- Display roles having more than 5 users
SELECT Role_ID,
       COUNT(*) AS User_Count
FROM Users
GROUP BY Role_ID
HAVING COUNT(*) > 5;


-- Display categories containing at least one challenge
SELECT Category_ID,
       COUNT(*) AS Challenge_Count
FROM Challenges
GROUP BY Category_ID
HAVING COUNT(*) >= 1;



-- ==========================================
-- 8. INNER JOIN
-- ==========================================

-- Display users with their role names
SELECT U.User_ID,
       U.Full_Name,
       U.Email,
       R.Role_Name
FROM Users U
INNER JOIN Roles R
    ON U.Role_ID = R.Role_ID
ORDER BY U.User_ID;


-- Display challenges with category names
SELECT C.Challenge_ID,
       C.Challenge_Name,
       C.Points,
       CAT.Category_Name
FROM Challenges C
INNER JOIN Categories CAT
    ON C.Category_ID = CAT.Category_ID
ORDER BY C.Challenge_ID;


-- Display challenges with their creators
SELECT C.Challenge_ID,
       C.Challenge_Name,
       U.Full_Name AS Creator_Name
FROM Challenges C
INNER JOIN Users U
    ON C.Created_By = U.User_ID;


-- Display submissions with user and challenge information
SELECT S.Submission_ID,
       U.Full_Name,
       C.Challenge_Name,
       S.Is_Correct,
       S.Score_Awarded
FROM Submissions S
INNER JOIN Users U
    ON S.User_ID = U.User_ID
INNER JOIN Challenges C
    ON S.Challenge_ID = C.Challenge_ID;



-- ==========================================
-- 9. JOIN with Teams
-- ==========================================

-- Display teams with their leaders
SELECT T.Team_ID,
       T.Team_Name,
       U.Full_Name AS Leader_Name
FROM Teams T
INNER JOIN Users U
    ON T.Leader_ID = U.User_ID;


-- Display team members
SELECT T.Team_Name,
       U.User_ID,
       U.Full_Name
FROM Team_Members TM
INNER JOIN Teams T
    ON TM.Team_ID = T.Team_ID
INNER JOIN Users U
    ON TM.User_ID = U.User_ID
ORDER BY T.Team_ID, U.User_ID;



-- ==========================================
-- 10. Training Sessions Queries
-- ==========================================

-- Display training sessions with trainer names
SELECT TS.Session_ID,
       TS.Session_Name,
       U.Full_Name AS Trainer_Name,
       TS.Session_Date,
       TS.Duration_Minutes
FROM Training_Sessions TS
INNER JOIN Users U
    ON TS.Trainer_ID = U.User_ID
ORDER BY TS.Session_Date;


-- Display session attendees
SELECT TS.Session_Name,
       U.Full_Name,
       SA.Attendance_Status
FROM Session_Attendees SA
INNER JOIN Training_Sessions TS
    ON SA.Session_ID = TS.Session_ID
INNER JOIN Users U
    ON SA.User_ID = U.User_ID
ORDER BY TS.Session_ID, U.User_ID;



-- ==========================================
-- 11. LEFT JOIN
-- ==========================================

-- Display all challenges including challenges without hints
SELECT C.Challenge_ID,
       C.Challenge_Name,
       H.Hint_Text,
       H.Points_Cost
FROM Challenges C
LEFT JOIN Hints H
    ON C.Challenge_ID = H.Challenge_ID
ORDER BY C.Challenge_ID;


-- Display all users including users with no submissions
SELECT U.User_ID,
       U.Full_Name,
       S.Submission_ID,
       S.Is_Correct
FROM Users U
LEFT JOIN Submissions S
    ON U.User_ID = S.User_ID
ORDER BY U.User_ID;



-- ==========================================
-- 12. Subqueries
-- ==========================================

-- Find challenges worth more than the average challenge points
SELECT Challenge_ID,
       Challenge_Name,
       Points
FROM Challenges
WHERE Points > (
    SELECT AVG(Points)
    FROM Challenges
);


-- Find users who have made submissions
SELECT User_ID,
       Full_Name
FROM Users
WHERE User_ID IN (
    SELECT User_ID
    FROM Submissions
);


-- Find users who have never made a submission
SELECT User_ID,
       Full_Name
FROM Users
WHERE User_ID NOT IN (
    SELECT User_ID
    FROM Submissions
);



-- ==========================================
-- 13. CASE Expression
-- ==========================================

-- Classify challenges based on their points
SELECT Challenge_ID,
       Challenge_Name,
       Points,
       CASE
           WHEN Points >= 200 THEN 'Hard'
           WHEN Points >= 150 THEN 'Medium'
           ELSE 'Easy'
       END AS Difficulty_Level
FROM Challenges
ORDER BY Points DESC;


-- Classify users according to account status
SELECT User_ID,
       Full_Name,
       Status,
       CASE
           WHEN Status = 'Active' THEN 'Available'
           WHEN Status = 'Inactive' THEN 'Not Active'
           ELSE 'Suspended Account'
       END AS Account_State
FROM Users;



-- ==========================================
-- 14. Submission Statistics
-- ==========================================

-- Total submissions
SELECT COUNT(*) AS Total_Submissions
FROM Submissions;


-- Correct submissions
SELECT COUNT(*) AS Correct_Submissions
FROM Submissions
WHERE Is_Correct = 'Y';


-- Incorrect submissions
SELECT COUNT(*) AS Incorrect_Submissions
FROM Submissions
WHERE Is_Correct = 'N';


-- Total score awarded
SELECT SUM(Score_Awarded) AS Total_Score_Awarded
FROM Submissions;



-- ==========================================
-- 15. Player Scores
-- ==========================================

-- Calculate total score for each user
SELECT U.User_ID,
       U.Full_Name,
       NVL(SUM(S.Score_Awarded), 0) AS Total_Score
FROM Users U
LEFT JOIN Submissions S
    ON U.User_ID = S.User_ID
GROUP BY U.User_ID,
         U.Full_Name
ORDER BY Total_Score DESC;



-- ==========================================
-- 16. Challenge Statistics
-- ==========================================

-- Display number of submissions for each challenge
SELECT C.Challenge_ID,
       C.Challenge_Name,
       COUNT(S.Submission_ID) AS Submission_Count
FROM Challenges C
LEFT JOIN Submissions S
    ON C.Challenge_ID = S.Challenge_ID
GROUP BY C.Challenge_ID,
         C.Challenge_Name
ORDER BY Submission_Count DESC;



-- ==========================================
-- 17. Hint Information
-- ==========================================

-- Display challenges and their hints
SELECT C.Challenge_Name,
       H.Hint_Text,
       H.Points_Cost
FROM Hints H
INNER JOIN Challenges C
    ON H.Challenge_ID = C.Challenge_ID
ORDER BY C.Challenge_ID;



-- ==========================================
-- 18. Audit Logs
-- ==========================================

-- Display all audit logs
SELECT Log_ID,
       User_ID,
       Action,
       Action_Date,
       IP_Address,
       Description
FROM Audit_Logs
ORDER BY Action_Date DESC;


-- Display audit logs with user names
SELECT A.Log_ID,
       U.Full_Name,
       A.Action,
       A.Action_Date,
       A.Description
FROM Audit_Logs A
LEFT JOIN Users U
    ON A.User_ID = U.User_ID
ORDER BY A.Action_Date DESC;



-- ==========================================
-- 19. EXPLAIN PLAN
-- ==========================================

-- Generate execution plan for searching active users
EXPLAIN PLAN FOR
SELECT User_ID,
       Full_Name,
       Email
FROM Users
WHERE Status = 'Active';


-- Display execution plan
SELECT *
FROM TABLE(DBMS_XPLAN.DISPLAY);



-- ==========================================
-- 20. Useful Reports
-- ==========================================

-- Top players by score
SELECT U.User_ID,
       U.Full_Name,
       NVL(SUM(S.Score_Awarded), 0) AS Total_Score
FROM Users U
LEFT JOIN Submissions S
    ON U.User_ID = S.User_ID
GROUP BY U.User_ID,
         U.Full_Name
ORDER BY Total_Score DESC;


-- Most difficult challenges based on points
SELECT Challenge_ID,
       Challenge_Name,
       Points
FROM Challenges
ORDER BY Points DESC;


-- Active challenges
SELECT Challenge_ID,
       Challenge_Name,
       Points,
       Status
FROM Challenges
WHERE Status = 'Active'
ORDER BY Points DESC;


-- ==========================================
-- End of 03_SQL_Queries.sql
-- ==========================================
