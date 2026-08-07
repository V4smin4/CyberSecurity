-- ==========================================
-- Cybersecurity Training CTF Database
-- File: 02_Insert_Data.sql
-- Description: Insert sample data (Oracle-valid syntax)
-- ==========================================

-- ==========================================
-- 1. Insert Roles
-- ==========================================

INSERT INTO Roles (Role_ID, Role_Name) VALUES (1, 'Admin');
INSERT INTO Roles (Role_ID, Role_Name) VALUES (2, 'Trainer');
INSERT INTO Roles (Role_ID, Role_Name) VALUES (3, 'Player');

COMMIT;

-- ==========================================
-- 2. Insert Users (1 to 56)
-- ==========================================

INSERT ALL
INTO Users (User_ID, Full_Name, Email, Password_Hash, Role_ID, Registration_Date, Last_Login, Status, Failed_Attempts)
VALUES (1,'Ahmed Hassan','ahmed@example.com','hash123',1, TO_DATE('2026-08-05','YYYY-MM-DD'), NULL,'Active',0)

INTO Users (User_ID, Full_Name, Email, Password_Hash, Role_ID, Registration_Date, Last_Login, Status, Failed_Attempts)
VALUES (2,'Sara Ali','sara@example.com','hash456',2, TO_DATE('2026-08-05','YYYY-MM-DD'), NULL,'Active',0)

INTO Users (User_ID, Full_Name, Email, Password_Hash, Role_ID, Registration_Date, Last_Login, Status, Failed_Attempts)
VALUES (3,'Omar Mohamed','omar@example.com','hash789',3, TO_DATE('2026-08-05','YYYY-MM-DD'), NULL,'Active',0)

INTO Users (User_ID, Full_Name, Email, Password_Hash, Role_ID, Registration_Date, Last_Login, Status, Failed_Attempts)
VALUES (4,'Yasmina Ahmad','yasmina@example.com','hash101',3, TO_DATE('2026-08-05','YYYY-MM-DD'), NULL,'Active',0)

INTO Users (User_ID, Full_Name, Email, Password_Hash, Role_ID, Registration_Date, Last_Login, Status, Failed_Attempts)
VALUES (5,'Mohamed Ali','mohamed5@example.com','hash005',2, TO_DATE('2026-08-06','YYYY-MM-DD'), NULL,'Active',0)

INTO Users (User_ID, Full_Name, Email, Password_Hash, Role_ID, Registration_Date, Last_Login, Status, Failed_Attempts)
VALUES (6,'Mahmoud Ahmed','mahmoud6@example.com','hash006',2, TO_DATE('2026-08-06','YYYY-MM-DD'), NULL,'Active',0)

INTO Users (User_ID, Full_Name, Email, Password_Hash, Role_ID, Registration_Date, Last_Login, Status, Failed_Attempts)
VALUES (7,'Omar Hassan','omar7@example.com','hash007',3, TO_DATE('2026-08-06','YYYY-MM-DD'), NULL,'Active',0)

INTO Users (User_ID, Full_Name, Email, Password_Hash, Role_ID, Registration_Date, Last_Login, Status, Failed_Attempts)
VALUES (8,'Mona Adel','mona8@example.com','hash008',3, TO_DATE('2026-08-06','YYYY-MM-DD'), NULL,'Active',0)

INTO Users (User_ID, Full_Name, Email, Password_Hash, Role_ID, Registration_Date, Last_Login, Status, Failed_Attempts)
VALUES (9,'Nour Ali','nour9@example.com','hash009',1, TO_DATE('2026-08-06','YYYY-MM-DD'), NULL,'Active',0)

INTO Users (User_ID, Full_Name, Email, Password_Hash, Role_ID, Registration_Date, Last_Login, Status, Failed_Attempts)
VALUES (10,'Youssef Samir','youssef10@example.com','hash010',3, TO_DATE('2026-08-06','YYYY-MM-DD'), NULL,'Active',0)

INTO Users (User_ID, Full_Name, Email, Password_Hash, Role_ID, Registration_Date, Last_Login, Status, Failed_Attempts)
VALUES (11,'Ali Ibrahim','ali11@example.com','hash011',3, TO_DATE('2026-08-06','YYYY-MM-DD'), NULL,'Active',0)

INTO Users (User_ID, Full_Name, Email, Password_Hash, Role_ID, Registration_Date, Last_Login, Status, Failed_Attempts)
VALUES (12,'Salma Tarek','salma12@example.com','hash012',3, TO_DATE('2026-08-06','YYYY-MM-DD'), NULL,'Active',0)

INTO Users (User_ID, Full_Name, Email, Password_Hash, Role_ID, Registration_Date, Last_Login, Status, Failed_Attempts)
VALUES (13,'Ahmed Mostafa','ahmed13@example.com','hash013',3, TO_DATE('2026-08-06','YYYY-MM-DD'), NULL,'Active',0)

INTO Users (User_ID, Full_Name, Email, Password_Hash, Role_ID, Registration_Date, Last_Login, Status, Failed_Attempts)
VALUES (14,'Fatma Salah','fatma14@example.com','hash014',1, TO_DATE('2026-08-06','YYYY-MM-DD'), NULL,'Active',0)

INTO Users (User_ID, Full_Name, Email, Password_Hash, Role_ID, Registration_Date, Last_Login, Status, Failed_Attempts)
VALUES (15,'Khaled Hany','khaled15@example.com','hash015',3, TO_DATE('2026-08-06','YYYY-MM-DD'), NULL,'Active',0)

INTO Users (User_ID, Full_Name, Email, Password_Hash, Role_ID, Registration_Date, Last_Login, Status, Failed_Attempts)
VALUES (16,'Sara Mahmoud','sara16@example.com','hash016',3, TO_DATE('2026-08-06','YYYY-MM-DD'), NULL,'Active',0)

INTO Users (User_ID, Full_Name, Email, Password_Hash, Role_ID, Registration_Date, Last_Login, Status, Failed_Attempts)
VALUES (17,'Eman Nabil','eman17@example.com','hash017',3, TO_DATE('2026-08-06','YYYY-MM-DD'), NULL,'Active',0)

INTO Users (User_ID, Full_Name, Email, Password_Hash, Role_ID, Registration_Date, Last_Login, Status, Failed_Attempts)
VALUES (18,'Hossam Adel','hossam18@example.com','hash018',3, TO_DATE('2026-08-06','YYYY-MM-DD'), NULL,'Active',0)

INTO Users (User_ID, Full_Name, Email, Password_Hash, Role_ID, Registration_Date, Last_Login, Status, Failed_Attempts)
VALUES (19,'Aya Wael','aya19@example.com','hash019',1, TO_DATE('2026-08-06','YYYY-MM-DD'), NULL,'Active',0)

INTO Users (User_ID, Full_Name, Email, Password_Hash, Role_ID, Registration_Date, Last_Login, Status, Failed_Attempts)
VALUES (20,'Karim Essam','karim20@example.com','hash020',3, TO_DATE('2026-08-06','YYYY-MM-DD'), TO_DATE('2026-08-06 10:36:07','YYYY-MM-DD HH24:MI:SS'),'Inactive',0)

INTO Users (User_ID, Full_Name, Email, Password_Hash, Role_ID, Registration_Date, Last_Login, Status, Failed_Attempts)
VALUES (21,'Reem Ahmed','reem21@example.com','hash021',3, TO_DATE('2026-08-06','YYYY-MM-DD'), NULL,'Active',0)

INTO Users (User_ID, Full_Name, Email, Password_Hash, Role_ID, Registration_Date, Last_Login, Status, Failed_Attempts)
VALUES (22,'Tamer Ali','tamer22@example.com','hash022',3, TO_DATE('2026-08-06','YYYY-MM-DD'), NULL,'Active',0)

INTO Users (User_ID, Full_Name, Email, Password_Hash, Role_ID, Registration_Date, Last_Login, Status, Failed_Attempts)
VALUES (23,'Menna Adel','menna23@example.com','hash023',3, TO_DATE('2026-08-06','YYYY-MM-DD'), NULL,'Active',0)

INTO Users (User_ID, Full_Name, Email, Password_Hash, Role_ID, Registration_Date, Last_Login, Status, Failed_Attempts)
VALUES (24,'Mostafa Gamal','mostafa24@example.com','hash024',1, TO_DATE('2026-08-06','YYYY-MM-DD'), NULL,'Active',0)

INTO Users (User_ID, Full_Name, Email, Password_Hash, Role_ID, Registration_Date, Last_Login, Status, Failed_Attempts)
VALUES (25,'Heba Samy','heba25@example.com','hash025',3, TO_DATE('2026-08-06','YYYY-MM-DD'), NULL,'Active',0)

INTO Users (User_ID, Full_Name, Email, Password_Hash, Role_ID, Registration_Date, Last_Login, Status, Failed_Attempts)
VALUES (26,'Islam Nasser','islam26@example.com','hash026',3, TO_DATE('2026-08-06','YYYY-MM-DD'), NULL,'Active',0)

INTO Users (User_ID, Full_Name, Email, Password_Hash, Role_ID, Registration_Date, Last_Login, Status, Failed_Attempts)
VALUES (27,'Rana Ashraf','rana27@example.com','hash027',3, TO_DATE('2026-08-06','YYYY-MM-DD'), NULL,'Active',0)

INTO Users (User_ID, Full_Name, Email, Password_Hash, Role_ID, Registration_Date, Last_Login, Status, Failed_Attempts)
VALUES (28,'Amr Fathy','amr28@example.com','hash028',3, TO_DATE('2026-08-06','YYYY-MM-DD'), NULL,'Active',0)

INTO Users (User_ID, Full_Name, Email, Password_Hash, Role_ID, Registration_Date, Last_Login, Status, Failed_Attempts)
VALUES (29,'Noha Adel','noha29@example.com','hash029',1, TO_DATE('2026-08-06','YYYY-MM-DD'), NULL,'Active',0)

INTO Users (User_ID, Full_Name, Email, Password_Hash, Role_ID, Registration_Date, Last_Login, Status, Failed_Attempts)
VALUES (30,'Walid Hassan','walid30@example.com','hash030',3, TO_DATE('2026-08-06','YYYY-MM-DD'), NULL,'Active',0)

INTO Users (User_ID, Full_Name, Email, Password_Hash, Role_ID, Registration_Date, Last_Login, Status, Failed_Attempts)
VALUES (31,'Sherif Ali','sherif31@example.com','hash031',3, TO_DATE('2026-08-06','YYYY-MM-DD'), NULL,'Active',0)

INTO Users (User_ID, Full_Name, Email, Password_Hash, Role_ID, Registration_Date, Last_Login, Status, Failed_Attempts)
VALUES (32,'Dina Mahmoud','dina32@example.com','hash032',3, TO_DATE('2026-08-06','YYYY-MM-DD'), NULL,'Active',0)

INTO Users (User_ID, Full_Name, Email, Password_Hash, Role_ID, Registration_Date, Last_Login, Status, Failed_Attempts)
VALUES (33,'Ayman Salah','ayman33@example.com','hash033',3, TO_DATE('2026-08-06','YYYY-MM-DD'), NULL,'Active',0)

INTO Users (User_ID, Full_Name, Email, Password_Hash, Role_ID, Registration_Date, Last_Login, Status, Failed_Attempts)
VALUES (34,'Nadine Tarek','nadine34@example.com','hash034',1, TO_DATE('2026-08-06','YYYY-MM-DD'), NULL,'Active',0)

INTO Users (User_ID, Full_Name, Email, Password_Hash, Role_ID, Registration_Date, Last_Login, Status, Failed_Attempts)
VALUES (35,'Hany Yasser','hany35@example.com','hash035',3, TO_DATE('2026-08-06','YYYY-MM-DD'), NULL,'Active',0)

INTO Users (User_ID, Full_Name, Email, Password_Hash, Role_ID, Registration_Date, Last_Login, Status, Failed_Attempts)
VALUES (36,'Marina Nabil','marina36@example.com','hash036',3, TO_DATE('2026-08-06','YYYY-MM-DD'), NULL,'Active',0)

INTO Users (User_ID, Full_Name, Email, Password_Hash, Role_ID, Registration_Date, Last_Login, Status, Failed_Attempts)
VALUES (37,'Ahmed Atef','ahmed37@example.com','hash037',3, TO_DATE('2026-08-06','YYYY-MM-DD'), NULL,'Active',0)

INTO Users (User_ID, Full_Name, Email, Password_Hash, Role_ID, Registration_Date, Last_Login, Status, Failed_Attempts)
VALUES (38,'Passant Ali','passant38@example.com','hash038',3, TO_DATE('2026-08-06','YYYY-MM-DD'), NULL,'Active',0)

INTO Users (User_ID, Full_Name, Email, Password_Hash, Role_ID, Registration_Date, Last_Login, Status, Failed_Attempts)
VALUES (39,'Mariam Samir','mariam39@example.com','hash039',1, TO_DATE('2026-08-06','YYYY-MM-DD'), NULL,'Active',0)

INTO Users (User_ID, Full_Name, Email, Password_Hash, Role_ID, Registration_Date, Last_Login, Status, Failed_Attempts)
VALUES (40,'Yahia Adel','yahia40@example.com','hash040',3, TO_DATE('2026-08-06','YYYY-MM-DD'), NULL,'Active',0)

INTO Users (User_ID, Full_Name, Email, Password_Hash, Role_ID, Registration_Date, Last_Login, Status, Failed_Attempts)
VALUES (41,'Belal Ahmed','belal41@example.com','hash041',3, TO_DATE('2026-08-06','YYYY-MM-DD'), NULL,'Active',0)

INTO Users (User_ID, Full_Name, Email, Password_Hash, Role_ID, Registration_Date, Last_Login, Status, Failed_Attempts)
VALUES (42,'Habiba Wael','habiba42@example.com','hash042',3, TO_DATE('2026-08-06','YYYY-MM-DD'), NULL,'Active',0)

INTO Users (User_ID, Full_Name, Email, Password_Hash, Role_ID, Registration_Date, Last_Login, Status, Failed_Attempts)
VALUES (43,'Mina Nader','mina43@example.com','hash043',3, TO_DATE('2026-08-06','YYYY-MM-DD'), NULL,'Active',0)

INTO Users (User_ID, Full_Name, Email, Password_Hash, Role_ID, Registration_Date, Last_Login, Status, Failed_Attempts)
VALUES (44,'Esraa Mohamed','esraa44@example.com','hash044',1, TO_DATE('2026-08-06','YYYY-MM-DD'), NULL,'Active',0)

INTO Users (User_ID, Full_Name, Email, Password_Hash, Role_ID, Registration_Date, Last_Login, Status, Failed_Attempts)
VALUES (45,'Ola Gamal','ola45@example.com','hash045',3, TO_DATE('2026-08-06','YYYY-MM-DD'), NULL,'Active',0)

INTO Users (User_ID, Full_Name, Email, Password_Hash, Role_ID, Registration_Date, Last_Login, Status, Failed_Attempts)
VALUES (46,'Adham Hossam','adham46@example.com','hash046',3, TO_DATE('2026-08-06','YYYY-MM-DD'), NULL,'Active',0)

INTO Users (User_ID, Full_Name, Email, Password_Hash, Role_ID, Registration_Date, Last_Login, Status, Failed_Attempts)
VALUES (47,'Malak Ali','malak47@example.com','hash047',3, TO_DATE('2026-08-06','YYYY-MM-DD'), NULL,'Active',0)

INTO Users (User_ID, Full_Name, Email, Password_Hash, Role_ID, Registration_Date, Last_Login, Status, Failed_Attempts)
VALUES (48,'Ramy Adel','ramy48@example.com','hash048',3, TO_DATE('2026-08-06','YYYY-MM-DD'), NULL,'Active',0)

INTO Users (User_ID, Full_Name, Email, Password_Hash, Role_ID, Registration_Date, Last_Login, Status, Failed_Attempts)
VALUES (49,'Nada Ahmed','nada49@example.com','hash049',1, TO_DATE('2026-08-06','YYYY-MM-DD'), NULL,'Active',0)

INTO Users (User_ID, Full_Name, Email, Password_Hash, Role_ID, Registration_Date, Last_Login, Status, Failed_Attempts)
VALUES (50,'Bassem Mostafa','bassem50@example.com','hash050',3, TO_DATE('2026-08-06','YYYY-MM-DD'), NULL,'Active',0)

INTO Users (User_ID, Full_Name, Email, Password_Hash, Role_ID, Registration_Date, Last_Login, Status, Failed_Attempts)
VALUES (51,'Doaa Hassan','doaa51@example.com','hash051',3, TO_DATE('2026-08-06','YYYY-MM-DD'), NULL,'Active',0)

INTO Users (User_ID, Full_Name, Email, Password_Hash, Role_ID, Registration_Date, Last_Login, Status, Failed_Attempts)
VALUES (52,'Ziad Ali','ziad52@example.com','hash052',3, TO_DATE('2026-08-06','YYYY-MM-DD'), NULL,'Active',0)

INTO Users (User_ID, Full_Name, Email, Password_Hash, Role_ID, Registration_Date, Last_Login, Status, Failed_Attempts)
VALUES (53,'Farah Adel','farah53@example.com','hash053',3, TO_DATE('2026-08-06','YYYY-MM-DD'), NULL,'Active',0)

INTO Users (User_ID, Full_Name, Email, Password_Hash, Role_ID, Registration_Date, Last_Login, Status, Failed_Attempts)
VALUES (54,'Shady Nabil','shady54@example.com','hash054',1, TO_DATE('2026-08-06','YYYY-MM-DD'), NULL,'Active',0)

INTO Users (User_ID, Full_Name, Email, Password_Hash, Role_ID, Registration_Date, Last_Login, Status, Failed_Attempts)
VALUES (55,'Rasha Samy','rasha55@example.com','hash055',3, TO_DATE('2026-08-06','YYYY-MM-DD'), NULL,'Active',0)

INTO Users (User_ID, Full_Name, Email, Password_Hash, Role_ID, Registration_Date, Last_Login, Status, Failed_Attempts)
VALUES (56,'Hazem Ibrahim','hazem56@example.com','hash056',3, TO_DATE('2026-08-06','YYYY-MM-DD'), NULL,'Active',0)

SELECT * FROM dual;

COMMIT;

-- ==========================================
-- 3. Insert Categories
-- ==========================================

INSERT INTO Categories (Category_ID, Category_Name, Description)
VALUES (1, 'Web Security', 'Web application security challenges');

INSERT INTO Categories (Category_ID, Category_Name, Description)
VALUES (2, 'Cryptography', 'Encryption and decryption challenges');

INSERT INTO Categories (Category_ID, Category_Name, Description)
VALUES (3, 'Forensics', 'Digital forensic investigations');

INSERT INTO Categories (Category_ID, Category_Name, Description)
VALUES (4, 'Reverse Engineering', 'Binary analysis and reverse engineering');

INSERT INTO Categories (Category_ID, Category_Name, Description)
VALUES (5, 'Networking', 'Network analysis and security');

COMMIT;

-- ==========================================
-- 4. Insert Challenges
-- ==========================================

INSERT INTO Challenges (Challenge_ID, Challenge_Name, Description, Points, Category_ID, Created_By, Max_Attempts)
VALUES (1, 'SQL Injection Basics', 'Learn SQL Injection', 100, 1, 1, 5);

INSERT INTO Challenges (Challenge_ID, Challenge_Name, Description, Points, Category_ID, Created_By, Max_Attempts)
VALUES (2, 'Caesar Cipher', 'Decrypt Caesar Cipher', 150, 2, 2, 3);

INSERT INTO Challenges (Challenge_ID, Challenge_Name, Description, Points, Category_ID, Created_By, Max_Attempts)
VALUES (3, 'Packet Analysis', 'Analyze network traffic', 200, 5, 2, 4);

INSERT INTO Challenges (Challenge_ID, Challenge_Name, Description, Points, Category_ID, Created_By, Max_Attempts)
VALUES (4, 'Hidden File', 'Find hidden evidence', 120, 3, 1, 3);

INSERT INTO Challenges (Challenge_ID, Challenge_Name, Description, Points, Category_ID, Created_By, Max_Attempts)
VALUES (5, 'Reverse Me', 'Reverse engineer the binary', 250, 4, 1, 2);

COMMIT;

-- ==========================================
-- 5. Insert Teams (8 teams)
-- ==========================================

INSERT INTO Teams (Team_ID, Team_Name, Leader_ID) VALUES (1, 'Cyber Hunters', 3);
INSERT INTO Teams (Team_ID, Team_Name, Leader_ID) VALUES (2, 'Security Masters', 4);
INSERT INTO Teams (Team_ID, Team_Name, Leader_ID) VALUES (3, 'Team Alpha', 10);
INSERT INTO Teams (Team_ID, Team_Name, Leader_ID) VALUES (4, 'Team Bravo', 11);
INSERT INTO Teams (Team_ID, Team_Name, Leader_ID) VALUES (5, 'Team Omega', 12);
INSERT INTO Teams (Team_ID, Team_Name, Leader_ID) VALUES (6, 'Team Delta', 13);
INSERT INTO Teams (Team_ID, Team_Name, Leader_ID) VALUES (7, 'Team Falcon', 14);
INSERT INTO Teams (Team_ID, Team_Name, Leader_ID) VALUES (8, 'Team Phantom', 15);

COMMIT;

-- ==========================================
-- 6. Insert Team_Members (16 members, 2 per team)
-- ==========================================

INSERT INTO Team_Members (Team_ID, User_ID) VALUES (1, 3);
INSERT INTO Team_Members (Team_ID, User_ID) VALUES (1, 4);
INSERT INTO Team_Members (Team_ID, User_ID) VALUES (2, 5);
INSERT INTO Team_Members (Team_ID, User_ID) VALUES (2, 6);
INSERT INTO Team_Members (Team_ID, User_ID) VALUES (3, 7);
INSERT INTO Team_Members (Team_ID, User_ID) VALUES (3, 8);
INSERT INTO Team_Members (Team_ID, User_ID) VALUES (4, 10);
INSERT INTO Team_Members (Team_ID, User_ID) VALUES (4, 11);
INSERT INTO Team_Members (Team_ID, User_ID) VALUES (5, 12);
INSERT INTO Team_Members (Team_ID, User_ID) VALUES (5, 13);
INSERT INTO Team_Members (Team_ID, User_ID) VALUES (6, 14);
INSERT INTO Team_Members (Team_ID, User_ID) VALUES (6, 15);
INSERT INTO Team_Members (Team_ID, User_ID) VALUES (7, 16);
INSERT INTO Team_Members (Team_ID, User_ID) VALUES (7, 17);
INSERT INTO Team_Members (Team_ID, User_ID) VALUES (8, 18);
INSERT INTO Team_Members (Team_ID, User_ID) VALUES (8, 19);

COMMIT;

-- ==========================================
-- 7. Insert Hints
-- ==========================================

INSERT INTO Hints (Hint_ID, Challenge_ID, Hint_Text, Points_Cost)
VALUES (1, 1, 'Check the login form carefully.', 10);

INSERT INTO Hints (Hint_ID, Challenge_ID, Hint_Text, Points_Cost)
VALUES (2, 2, 'Think about alphabet shifting.', 15);

INSERT INTO Hints (Hint_ID, Challenge_ID, Hint_Text, Points_Cost)
VALUES (3, 3, 'Inspect the captured packets.', 20);

INSERT INTO Hints (Hint_ID, Challenge_ID, Hint_Text, Points_Cost)
VALUES (4, 4, 'Hidden files may exist.', 10);

INSERT INTO Hints (Hint_ID, Challenge_ID, Hint_Text, Points_Cost)
VALUES (5, 5, 'Use reverse engineering tools.', 25);

COMMIT;

-- ==========================================
-- 8. Insert Submissions
-- ==========================================

INSERT INTO Submissions (Submission_ID, User_ID, Challenge_ID, Is_Correct, IP_Address, Score_Awarded)
VALUES (1, 3, 1, 'Y', '192.168.1.10', 100);

INSERT INTO Submissions (Submission_ID, User_ID, Challenge_ID, Is_Correct, IP_Address, Score_Awarded)
VALUES (2, 4, 2, 'N', '192.168.1.11', 0);

INSERT INTO Submissions (Submission_ID, User_ID, Challenge_ID, Is_Correct, IP_Address, Score_Awarded)
VALUES (3, 2, 3, 'Y', '192.168.1.12', 200);

INSERT INTO Submissions (Submission_ID, User_ID, Challenge_ID, Is_Correct, IP_Address, Score_Awarded)
VALUES (4, 1, 5, 'Y', '192.168.1.13', 250);

COMMIT;

-- ==========================================
-- 9. Insert Training_Sessions
-- ==========================================

INSERT INTO Training_Sessions (Session_ID, Session_Name, Description, Trainer_ID, Session_Date, Duration_Minutes)
VALUES (1, 'SQL Security', 'Introduction to SQL Injection', 2, DATE '2026-08-01', 120);

INSERT INTO Training_Sessions (Session_ID, Session_Name, Description, Trainer_ID, Session_Date, Duration_Minutes)
VALUES (2, 'Network Security', 'Packet Analysis Workshop', 2, DATE '2026-08-05', 180);

COMMIT;

-- ==========================================
-- 10. Insert Session_Attendees
-- ==========================================

INSERT INTO Session_Attendees (Session_ID, User_ID, Attendance_Status)
VALUES (1, 3, 'Attended');

INSERT INTO Session_Attendees (Session_ID, User_ID, Attendance_Status)
VALUES (1, 4, 'Registered');

INSERT INTO Session_Attendees (Session_ID, User_ID, Attendance_Status)
VALUES (2, 1, 'Attended');

INSERT INTO Session_Attendees (Session_ID, User_ID, Attendance_Status)
VALUES (2, 2, 'Attended');

COMMIT;

-- ==========================================
-- 11. Insert Audit_Logs
-- ==========================================

INSERT INTO Audit_Logs (Log_ID, User_ID, Action, IP_Address, Description)
VALUES (1, 1, 'CREATE CHALLENGE', '192.168.1.2', 'Admin created challenge');

INSERT INTO Audit_Logs (Log_ID, User_ID, Action, IP_Address, Description)
VALUES (2, 2, 'CREATE SESSION', '192.168.1.3', 'Trainer created session');

INSERT INTO Audit_Logs (Log_ID, User_ID, Action, IP_Address, Description)
VALUES (3, 3, 'SUBMIT FLAG', '192.168.1.10', 'Successful submission');

INSERT INTO Audit_Logs (Log_ID, User_ID, Action, IP_Address, Description)
VALUES (4, 4, 'LOGIN', '192.168.1.11', 'User login');

COMMIT;
