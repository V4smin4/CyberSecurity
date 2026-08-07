-- ==========================================
-- Cybersecurity Training CTF Database
-- File: 01_Create_Tables.sql
-- Description: Create database tables
-- ==========================================

-- ==========================================
-- 1. Roles Table
-- ==========================================

CREATE TABLE Roles (
    Role_ID NUMBER PRIMARY KEY,
    Role_Name VARCHAR2(30) NOT NULL UNIQUE
);

-- ==========================================
-- 2. Users Table
-- ==========================================

CREATE TABLE Users (
    User_ID NUMBER PRIMARY KEY,
    Full_Name VARCHAR2(100) NOT NULL,
    Email VARCHAR2(150) NOT NULL UNIQUE,
    Password_Hash VARCHAR2(255) NOT NULL,
    Role_ID NUMBER NOT NULL,
    Registration_Date DATE DEFAULT SYSDATE,
    Last_Login DATE,
    Status VARCHAR2(20) DEFAULT 'Active' NOT NULL,
    Failed_Attempts NUMBER DEFAULT 0 NOT NULL,
    Account_Locked CHAR(1) DEFAULT 'N' NOT NULL,

    CONSTRAINT CHK_USER_STATUS
        CHECK (Status IN ('Active','Inactive','Suspended')),

    CONSTRAINT CHK_ACCOUNT_LOCKED
        CHECK (Account_Locked IN ('Y','N')),

    CONSTRAINT CHK_FAILED_ATTEMPTS
        CHECK (Failed_Attempts >= 0),

    CONSTRAINT FK_USERS_ROLE
        FOREIGN KEY (Role_ID)
        REFERENCES Roles(Role_ID)
);

-- ==========================================
-- 3. Categories Table
-- ==========================================

CREATE TABLE Categories (
    Category_ID NUMBER PRIMARY KEY,
    Category_Name VARCHAR2(50) NOT NULL UNIQUE,
    Description VARCHAR2(500)
);

-- ==========================================
-- 4. Challenges Table
-- ==========================================

CREATE TABLE Challenges (
    Challenge_ID NUMBER PRIMARY KEY,
    Challenge_Name VARCHAR2(150) NOT NULL,
    Description VARCHAR2(1000),
    Points NUMBER NOT NULL,
    Category_ID NUMBER NOT NULL,
    Created_By NUMBER NOT NULL,
    Max_Attempts NUMBER DEFAULT 0 NOT NULL,
    Created_Date DATE DEFAULT SYSDATE,
    Updated_Date DATE,
    Status VARCHAR2(20) DEFAULT 'Active' NOT NULL,

    CONSTRAINT CHK_CHALLENGE_POINTS
        CHECK (Points > 0),

    CONSTRAINT CHK_MAX_ATTEMPTS
        CHECK (Max_Attempts >= 0),

    CONSTRAINT CHK_CHALLENGE_STATUS
        CHECK (Status IN ('Active','Inactive')),

    CONSTRAINT FK_CHALLENGE_CATEGORY
        FOREIGN KEY (Category_ID)
        REFERENCES Categories(Category_ID),

    CONSTRAINT FK_CHALLENGE_CREATOR
        FOREIGN KEY (Created_By)
        REFERENCES Users(User_ID)
);

-- ==========================================
-- 5. Teams Table
-- ==========================================

CREATE TABLE Teams (
    Team_ID NUMBER PRIMARY KEY,
    Team_Name VARCHAR2(100) NOT NULL UNIQUE,
    Leader_ID NUMBER NOT NULL,
    Created_Date DATE DEFAULT SYSDATE,

    CONSTRAINT FK_TEAM_LEADER
        FOREIGN KEY (Leader_ID)
        REFERENCES Users(User_ID)
);

-- ==========================================
-- 6. Team_Members Table
-- ==========================================

CREATE TABLE Team_Members (
    Team_ID NUMBER NOT NULL,
    User_ID NUMBER NOT NULL,
    Join_Date DATE DEFAULT SYSDATE,

    CONSTRAINT PK_TEAM_MEMBERS
        PRIMARY KEY (Team_ID, User_ID),

    CONSTRAINT FK_TM_TEAM
        FOREIGN KEY (Team_ID)
        REFERENCES Teams(Team_ID),

    CONSTRAINT FK_TM_USER
        FOREIGN KEY (User_ID)
        REFERENCES Users(User_ID)
);

-- ==========================================
-- 7. Hints Table
-- ==========================================

CREATE TABLE Hints (
    Hint_ID NUMBER PRIMARY KEY,
    Challenge_ID NUMBER NOT NULL,
    Hint_Text VARCHAR2(1000) NOT NULL,
    Points_Cost NUMBER DEFAULT 0 NOT NULL,

    CONSTRAINT CHK_HINT_COST
        CHECK (Points_Cost >= 0),

    CONSTRAINT FK_HINT_CHALLENGE
        FOREIGN KEY (Challenge_ID)
        REFERENCES Challenges(Challenge_ID)
);

-- ==========================================
-- 8. Submissions Table
-- ==========================================

CREATE TABLE Submissions (
    Submission_ID NUMBER PRIMARY KEY,
    User_ID NUMBER NOT NULL,
    Challenge_ID NUMBER NOT NULL,
    Is_Correct CHAR(1) DEFAULT 'N' NOT NULL,
    Submission_Time DATE DEFAULT SYSDATE,
    IP_Address VARCHAR2(45),
    Score_Awarded NUMBER DEFAULT 0 NOT NULL,

    CONSTRAINT CHK_SUBMISSION_CORRECT
        CHECK (Is_Correct IN ('Y','N')),

    CONSTRAINT CHK_SCORE_AWARDED
        CHECK (Score_Awarded >= 0),

    CONSTRAINT FK_SUBMISSION_USER
        FOREIGN KEY (User_ID)
        REFERENCES Users(User_ID),

    CONSTRAINT FK_SUBMISSION_CHALLENGE
        FOREIGN KEY (Challenge_ID)
        REFERENCES Challenges(Challenge_ID)
);

-- ==========================================
-- 9. Training_Sessions Table
-- ==========================================

CREATE TABLE Training_Sessions (
    Session_ID NUMBER PRIMARY KEY,
    Session_Name VARCHAR2(150) NOT NULL,
    Description VARCHAR2(1000),
    Trainer_ID NUMBER NOT NULL,
    Session_Date DATE NOT NULL,
    Duration_Minutes NUMBER,

    CONSTRAINT CHK_SESSION_DURATION
        CHECK (Duration_Minutes > 0),

    CONSTRAINT FK_SESSION_TRAINER
        FOREIGN KEY (Trainer_ID)
        REFERENCES Users(User_ID)
);

-- ==========================================
-- 10. Session_Attendees Table
-- ==========================================

CREATE TABLE Session_Attendees (
    Session_ID NUMBER NOT NULL,
    User_ID NUMBER NOT NULL,
    Attendance_Status VARCHAR2(20)
        DEFAULT 'Registered' NOT NULL,

    CONSTRAINT PK_SESSION_ATTENDEES
        PRIMARY KEY (Session_ID, User_ID),

    CONSTRAINT CHK_ATTENDANCE_STATUS
        CHECK (Attendance_Status IN
        ('Registered','Attended','Absent')),

    CONSTRAINT FK_SA_SESSION
        FOREIGN KEY (Session_ID)
        REFERENCES Training_Sessions(Session_ID),

    CONSTRAINT FK_SA_USER
        FOREIGN KEY (User_ID)
        REFERENCES Users(User_ID)
);

-- ==========================================
-- 11. Audit_Logs Table
-- ==========================================

CREATE TABLE Audit_Logs (
    Log_ID NUMBER PRIMARY KEY,
    User_ID NUMBER,
    Action VARCHAR2(100) NOT NULL,
    Action_Date DATE DEFAULT SYSDATE,
    IP_Address VARCHAR2(45),
    Description VARCHAR2(1000),

    CONSTRAINT FK_AUDIT_USER
        FOREIGN KEY (User_ID)
        REFERENCES Users(User_ID)
);
