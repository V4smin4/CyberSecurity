# Data Dictionary

This document lists every table, column, data type, and constraint in the
Cybersecurity Training CTF Database, exactly as defined in
`SQL/01_Create_Tables.sql`.

---

## 1. Roles

| Column | Data Type | Nullable | Default | Constraints | Description |
|---|---|---|---|---|---|
| Role_ID | NUMBER | No | — | PRIMARY KEY | Unique identifier for the role |
| Role_Name | VARCHAR2(30) | No | — | UNIQUE | Role name (Admin, Trainer, Player) |

## 2. Users

| Column | Data Type | Nullable | Default | Constraints | Description |
|---|---|---|---|---|---|
| User_ID | NUMBER | No | — | PRIMARY KEY | Unique identifier for the user |
| Full_Name | VARCHAR2(100) | No | — | — | User's full name |
| Email | VARCHAR2(150) | No | — | UNIQUE | User's email address |
| Password_Hash | VARCHAR2(255) | No | — | — | Hashed password |
| Role_ID | NUMBER | No | — | FK → Roles(Role_ID) | User's assigned role |
| Registration_Date | DATE | Yes | SYSDATE | — | Date the account was created |
| Last_Login | DATE | Yes | — | — | Timestamp of the most recent login |
| Status | VARCHAR2(20) | No | 'Active' | CHECK IN ('Active','Inactive','Suspended') | Account status |
| Failed_Attempts | NUMBER | No | 0 | CHECK (>= 0) | Consecutive failed login attempts |
| Account_Locked | CHAR(1) | No | 'N' | CHECK IN ('Y','N') | Whether the account is locked |

## 3. Categories

| Column | Data Type | Nullable | Default | Constraints | Description |
|---|---|---|---|---|---|
| Category_ID | NUMBER | No | — | PRIMARY KEY | Unique identifier for the category |
| Category_Name | VARCHAR2(50) | No | — | UNIQUE | Category name (e.g. Web Security) |
| Description | VARCHAR2(500) | Yes | — | — | Description of the category |

## 4. Challenges

| Column | Data Type | Nullable | Default | Constraints | Description |
|---|---|---|---|---|---|
| Challenge_ID | NUMBER | No | — | PRIMARY KEY | Unique identifier for the challenge |
| Challenge_Name | VARCHAR2(150) | No | — | — | Challenge title |
| Description | VARCHAR2(1000) | Yes | — | — | Challenge description |
| Points | NUMBER | No | — | CHECK (> 0) | Points awarded for a correct solve |
| Category_ID | NUMBER | No | — | FK → Categories(Category_ID) | Challenge's category |
| Created_By | NUMBER | No | — | FK → Users(User_ID) | User who created the challenge |
| Max_Attempts | NUMBER | No | 0 | CHECK (>= 0) | Attempt limit (0 = unlimited) |
| Created_Date | DATE | Yes | SYSDATE | — | Date the challenge was created |
| Updated_Date | DATE | Yes | — | — | Date the challenge was last updated |
| Status | VARCHAR2(20) | No | 'Active' | CHECK IN ('Active','Inactive') | Challenge status |

## 5. Teams

| Column | Data Type | Nullable | Default | Constraints | Description |
|---|---|---|---|---|---|
| Team_ID | NUMBER | No | — | PRIMARY KEY | Unique identifier for the team |
| Team_Name | VARCHAR2(100) | No | — | UNIQUE | Team name |
| Leader_ID | NUMBER | No | — | FK → Users(User_ID) | User who leads the team |
| Created_Date | DATE | Yes | SYSDATE | — | Date the team was created |

## 6. Team_Members

| Column | Data Type | Nullable | Default | Constraints | Description |
|---|---|---|---|---|---|
| Team_ID | NUMBER | No | — | PK (composite), FK → Teams(Team_ID) | Team the user belongs to |
| User_ID | NUMBER | No | — | PK (composite), FK → Users(User_ID) | Member's user ID |
| Join_Date | DATE | Yes | SYSDATE | — | Date the user joined the team |

## 7. Hints

| Column | Data Type | Nullable | Default | Constraints | Description |
|---|---|---|---|---|---|
| Hint_ID | NUMBER | No | — | PRIMARY KEY | Unique identifier for the hint |
| Challenge_ID | NUMBER | No | — | FK → Challenges(Challenge_ID) | Challenge the hint belongs to |
| Hint_Text | VARCHAR2(1000) | No | — | — | Hint content |
| Points_Cost | NUMBER | No | 0 | CHECK (>= 0) | Points deducted for using the hint |

## 8. Submissions

| Column | Data Type | Nullable | Default | Constraints | Description |
|---|---|---|---|---|---|
| Submission_ID | NUMBER | No | — | PRIMARY KEY | Unique identifier for the submission |
| User_ID | NUMBER | No | — | FK → Users(User_ID) | User who submitted |
| Challenge_ID | NUMBER | No | — | FK → Challenges(Challenge_ID) | Challenge attempted |
| Is_Correct | CHAR(1) | No | 'N' | CHECK IN ('Y','N') | Whether the submission was correct |
| Submission_Time | DATE | Yes | SYSDATE | — | Timestamp of the submission |
| IP_Address | VARCHAR2(45) | Yes | — | — | Source IP address of the submission |
| Score_Awarded | NUMBER | No | 0 | CHECK (>= 0) | Points awarded for this submission |

## 9. Training_Sessions

| Column | Data Type | Nullable | Default | Constraints | Description |
|---|---|---|---|---|---|
| Session_ID | NUMBER | No | — | PRIMARY KEY | Unique identifier for the session |
| Session_Name | VARCHAR2(150) | No | — | — | Session title |
| Description | VARCHAR2(1000) | Yes | — | — | Session description |
| Trainer_ID | NUMBER | No | — | FK → Users(User_ID) | Trainer leading the session |
| Session_Date | DATE | No | — | — | Date the session takes place |
| Duration_Minutes | NUMBER | Yes | — | CHECK (> 0) | Session duration in minutes |

## 10. Session_Attendees

| Column | Data Type | Nullable | Default | Constraints | Description |
|---|---|---|---|---|---|
| Session_ID | NUMBER | No | — | PK (composite), FK → Training_Sessions(Session_ID) | Session being attended |
| User_ID | NUMBER | No | — | PK (composite), FK → Users(User_ID) | Attending user |
| Attendance_Status | VARCHAR2(20) | No | 'Registered' | CHECK IN ('Registered','Attended','Absent') | Attendance outcome |

## 11. Audit_Logs

| Column | Data Type | Nullable | Default | Constraints | Description |
|---|---|---|---|---|---|
| Log_ID | NUMBER | No | — | PRIMARY KEY | Unique identifier for the log entry |
| User_ID | NUMBER | Yes | — | FK → Users(User_ID) | User associated with the action (nullable for system-level events) |
| Action | VARCHAR2(100) | No | — | — | Action performed (e.g. LOGIN, SUBMISSION) |
| Action_Date | DATE | Yes | SYSDATE | — | Timestamp of the action |
| IP_Address | VARCHAR2(45) | Yes | — | — | Source IP address |
| Description | VARCHAR2(1000) | Yes | — | — | Free-text description of the action |

---

## 12. Views

### V_ACTIVE_CHALLENGES
All challenges whose `Status = 'Active'`. Columns: `Challenge_ID`,
`Challenge_Name`, `Description`, `Points`, `Category_ID`, `Created_By`,
`Max_Attempts`, `Created_Date`, `Status`.

### V_USER_SUBMISSION_SUMMARY
One row per user (via `LEFT JOIN`, so users with no submissions still
appear). Columns: `User_ID`, `Full_Name`, `Total_Submissions`,
`Correct_Submissions`, `Total_Score`.

---

## 13. Indexes

| Index Name | Table | Column(s) | Purpose |
|---|---|---|---|
| IDX_SUBMISSIONS_USER | Submissions | User_ID | Speeds up filtering submissions by user |
| IDX_SUBMISSIONS_CHALLENGE | Submissions | Challenge_ID | Speeds up joins between Submissions and Challenges |
| IDX_CHALLENGES_CATEGORY | Challenges | Category_ID | Speeds up filtering challenges by category |
| IDX_TEAM_MEMBERS_TEAM | Team_Members | Team_ID | Overlaps with the composite PK index; kept for clarity |
| IDX_TEAM_MEMBERS_USER | Team_Members | User_ID | Speeds up looking up a user's team |

*(Note: Primary key and unique constraints listed above each create an
implicit index automatically; only the additional, explicitly created
indexes are listed here.)*
