-- ==========================================
-- Cybersecurity Training CTF Database
-- File: 05_Procedures.sql
-- Description: Stored Procedures
-- Database: Oracle
-- ==========================================


-- ==========================================
-- 1. Register User
-- ==========================================
-- Creates a new user in the Users table.
-- The procedure validates the role before insertion.

CREATE OR REPLACE PROCEDURE Register_User (
    p_user_id            IN Users.User_ID%TYPE,
    p_full_name          IN Users.Full_Name%TYPE,
    p_email              IN Users.Email%TYPE,
    p_password_hash      IN Users.Password_Hash%TYPE,
    p_role_id            IN Users.Role_ID%TYPE
)
AS
    v_role_count NUMBER;
BEGIN

    -- Check whether the role exists
    SELECT COUNT(*)
    INTO v_role_count
    FROM Roles
    WHERE Role_ID = p_role_id;

    IF v_role_count = 0 THEN
        RAISE_APPLICATION_ERROR(
            -20001,
            'Invalid Role_ID. The specified role does not exist.'
        );
    END IF;

    -- Insert new user
    INSERT INTO Users (
        User_ID,
        Full_Name,
        Email,
        Password_Hash,
        Role_ID,
        Registration_Date,
        Status,
        Failed_Attempts,
        Account_Locked
    )
    VALUES (
        p_user_id,
        p_full_name,
        p_email,
        p_password_hash,
        p_role_id,
        SYSDATE,
        'Active',
        0,
        'N'
    );

EXCEPTION
    WHEN DUP_VAL_ON_INDEX THEN
        RAISE_APPLICATION_ERROR(
            -20002,
            'User_ID or Email already exists.'
        );
END Register_User;
/


-- ==========================================
-- 2. Create Challenge
-- ==========================================
-- Creates a new CTF challenge.
-- Only Admin or Trainer users can create challenges.

CREATE OR REPLACE PROCEDURE Create_Challenge (
    p_challenge_id      IN Challenges.Challenge_ID%TYPE,
    p_challenge_name    IN Challenges.Challenge_Name%TYPE,
    p_description       IN Challenges.Description%TYPE,
    p_points             IN Challenges.Points%TYPE,
    p_category_id       IN Challenges.Category_ID%TYPE,
    p_created_by        IN Challenges.Created_By%TYPE,
    p_max_attempts      IN Challenges.Max_Attempts%TYPE DEFAULT 0
)
AS
    v_user_role NUMBER;
    v_category_count NUMBER;
BEGIN

    -- Check creator role
    SELECT Role_ID
    INTO v_user_role
    FROM Users
    WHERE User_ID = p_created_by;

    IF v_user_role NOT IN (1, 2) THEN
        RAISE_APPLICATION_ERROR(
            -20003,
            'Only Admin or Trainer users can create challenges.'
        );
    END IF;

    -- Check category exists
    SELECT COUNT(*)
    INTO v_category_count
    FROM Categories
    WHERE Category_ID = p_category_id;

    IF v_category_count = 0 THEN
        RAISE_APPLICATION_ERROR(
            -20004,
            'The specified Category_ID does not exist.'
        );
    END IF;

    -- Validate points
    IF p_points <= 0 THEN
        RAISE_APPLICATION_ERROR(
            -20005,
            'Challenge points must be greater than zero.'
        );
    END IF;

    -- Validate maximum attempts
    IF p_max_attempts < 0 THEN
        RAISE_APPLICATION_ERROR(
            -20006,
            'Max_Attempts cannot be negative.'
        );
    END IF;

    -- Insert challenge
    INSERT INTO Challenges (
        Challenge_ID,
        Challenge_Name,
        Description,
        Points,
        Category_ID,
        Created_By,
        Max_Attempts,
        Created_Date,
        Status
    )
    VALUES (
        p_challenge_id,
        p_challenge_name,
        p_description,
        p_points,
        p_category_id,
        p_created_by,
        p_max_attempts,
        SYSDATE,
        'Active'
    );

EXCEPTION
    WHEN NO_DATA_FOUND THEN
        RAISE_APPLICATION_ERROR(
            -20007,
            'The specified creator does not exist.'
        );

    WHEN DUP_VAL_ON_INDEX THEN
        RAISE_APPLICATION_ERROR(
            -20008,
            'Challenge_ID already exists.'
        );
END Create_Challenge;
/


-- ==========================================
-- 3. Submit Flag
-- ==========================================
-- Records a user's challenge submission.
--
-- Note:
-- The current Challenges table does not contain
-- a Flag column. Therefore, the procedure receives
-- the result of flag validation through p_is_correct.
--
-- If the submission is correct, the user receives
-- the challenge points.
-- If incorrect, the awarded score is zero.

CREATE OR REPLACE PROCEDURE Submit_Flag (
    p_submission_id    IN Submissions.Submission_ID%TYPE,
    p_user_id          IN Submissions.User_ID%TYPE,
    p_challenge_id     IN Submissions.Challenge_ID%TYPE,
    p_is_correct       IN Submissions.Is_Correct%TYPE,
    p_ip_address       IN Submissions.IP_Address%TYPE
)
AS
    v_challenge_status Challenges.Status%TYPE;
    v_challenge_points Challenges.Points%TYPE;
    v_max_attempts Challenges.Max_Attempts%TYPE;
    v_attempt_count NUMBER;
    v_score NUMBER;
    v_user_status Users.Status%TYPE;
BEGIN

    -- Check user status
    SELECT Status
    INTO v_user_status
    FROM Users
    WHERE User_ID = p_user_id;

    IF v_user_status <> 'Active' THEN
        RAISE_APPLICATION_ERROR(
            -20009,
            'The user account is not active.'
        );
    END IF;

    -- Check challenge information
    SELECT
        Status,
        Points,
        Max_Attempts
    INTO
        v_challenge_status,
        v_challenge_points,
        v_max_attempts
    FROM Challenges
    WHERE Challenge_ID = p_challenge_id;

    -- Challenge must be active
    IF v_challenge_status <> 'Active' THEN
        RAISE_APPLICATION_ERROR(
            -20010,
            'The challenge is not active.'
        );
    END IF;

    -- Validate Is_Correct
    IF p_is_correct NOT IN ('Y', 'N') THEN
        RAISE_APPLICATION_ERROR(
            -20011,
            'Is_Correct must be Y or N.'
        );
    END IF;

    -- Count previous attempts
    SELECT COUNT(*)
    INTO v_attempt_count
    FROM Submissions
    WHERE User_ID = p_user_id
      AND Challenge_ID = p_challenge_id;

    -- Max_Attempts = 0 means unlimited attempts
    IF v_max_attempts > 0
       AND v_attempt_count >= v_max_attempts THEN

        RAISE_APPLICATION_ERROR(
            -20012,
            'Maximum number of attempts has been reached.'
        );

    END IF;

    -- Calculate score
    IF p_is_correct = 'Y' THEN
        v_score := v_challenge_points;
    ELSE
        v_score := 0;
    END IF;

    -- Insert submission
    INSERT INTO Submissions (
        Submission_ID,
        User_ID,
        Challenge_ID,
        Is_Correct,
        Submission_Time,
        IP_Address,
        Score_Awarded
    )
    VALUES (
        p_submission_id,
        p_user_id,
        p_challenge_id,
        p_is_correct,
        SYSDATE,
        p_ip_address,
        v_score
    );

EXCEPTION
    WHEN NO_DATA_FOUND THEN
        RAISE_APPLICATION_ERROR(
            -20013,
            'User or Challenge does not exist.'
        );

    WHEN DUP_VAL_ON_INDEX THEN
        RAISE_APPLICATION_ERROR(
            -20014,
            'Submission_ID already exists.'
        );
END Submit_Flag;
/


-- ==========================================
-- 4. Assign User To Team
-- ==========================================
-- Adds a user to a team.
--
-- Business rule:
-- A user can belong to only one team.

CREATE OR REPLACE PROCEDURE Assign_Team (
    p_team_id   IN Team_Members.Team_ID%TYPE,
    p_user_id   IN Team_Members.User_ID%TYPE
)
AS
    v_team_count NUMBER;
    v_user_count NUMBER;
    v_membership_count NUMBER;
BEGIN

    -- Check team exists
    SELECT COUNT(*)
    INTO v_team_count
    FROM Teams
    WHERE Team_ID = p_team_id;

    IF v_team_count = 0 THEN
        RAISE_APPLICATION_ERROR(
            -20015,
            'The specified Team_ID does not exist.'
        );
    END IF;

    -- Check user exists
    SELECT COUNT(*)
    INTO v_user_count
    FROM Users
    WHERE User_ID = p_user_id;

    IF v_user_count = 0 THEN
        RAISE_APPLICATION_ERROR(
            -20016,
            'The specified User_ID does not exist.'
        );
    END IF;

    -- Check if user already belongs to a team
    SELECT COUNT(*)
    INTO v_membership_count
    FROM Team_Members
    WHERE User_ID = p_user_id;

    IF v_membership_count > 0 THEN
        RAISE_APPLICATION_ERROR(
            -20017,
            'The user already belongs to a team.'
        );
    END IF;

    -- Assign user to team
    INSERT INTO Team_Members (
        Team_ID,
        User_ID,
        Join_Date
    )
    VALUES (
        p_team_id,
        p_user_id,
        SYSDATE
    );

EXCEPTION
    WHEN DUP_VAL_ON_INDEX THEN
        RAISE_APPLICATION_ERROR(
            -20018,
            'The user is already a member of this team.'
        );
END Assign_Team;
/


-- ==========================================
-- 5. Add Hint
-- ==========================================
-- Adds a hint to an existing challenge.

CREATE OR REPLACE PROCEDURE Add_Hint (
    p_hint_id        IN Hints.Hint_ID%TYPE,
    p_challenge_id   IN Hints.Challenge_ID%TYPE,
    p_hint_text      IN Hints.Hint_Text%TYPE,
    p_points_cost    IN Hints.Points_Cost%TYPE
)
AS
    v_challenge_count NUMBER;
    v_challenge_status Challenges.Status%TYPE;
BEGIN

    -- Check challenge
    SELECT Status
    INTO v_challenge_status
    FROM Challenges
    WHERE Challenge_ID = p_challenge_id;

    -- Hint can only be added to an active challenge
    IF v_challenge_status <> 'Active' THEN
        RAISE_APPLICATION_ERROR(
            -20019,
            'Hints can only be added to active challenges.'
        );
    END IF;

    -- Validate points cost
    IF p_points_cost < 0 THEN
        RAISE_APPLICATION_ERROR(
            -20020,
            'Hint points cost cannot be negative.'
        );
    END IF;

    -- Validate hint text
    IF p_hint_text IS NULL THEN
        RAISE_APPLICATION_ERROR(
            -20021,
            'Hint text cannot be empty.'
        );
    END IF;

    -- Insert hint
    INSERT INTO Hints (
        Hint_ID,
        Challenge_ID,
        Hint_Text,
        Points_Cost
    )
    VALUES (
        p_hint_id,
        p_challenge_id,
        p_hint_text,
        p_points_cost
    );

EXCEPTION
    WHEN NO_DATA_FOUND THEN
        RAISE_APPLICATION_ERROR(
            -20022,
            'The specified challenge does not exist.'
        );

    WHEN DUP_VAL_ON_INDEX THEN
        RAISE_APPLICATION_ERROR(
            -20023,
            'Hint_ID already exists.'
        );
END Add_Hint;
/
