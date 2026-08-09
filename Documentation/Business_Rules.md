# Business Rules

This document lists the business rules that govern the Cybersecurity
Training CTF Database. For each rule, the enforcement layer is noted:

- *Database constraint* — enforced automatically by Oracle (PK/FK/CHECK),
  cannot be bypassed regardless of how data is inserted.
- *Procedure logic* — enforced only when data is entered through the
  provided PL/SQL procedure, not by the table schema itself.
- *Trigger* — enforced automatically after a specific event, regardless
  of which procedure (if any) performed the event.

---

## 1. Users

| Rule | Enforcement |
|---|---|
| Each user has exactly one role (Admin, Trainer, or Player). | Database constraint (Users.Role_ID FK, NOT NULL) |
| A user's email address must be unique. | Database constraint (UNIQUE) |
| A user's account status must be Active, Inactive, or Suspended. | Database constraint (CHECK) |
| Failed login attempts cannot be negative. | Database constraint (CHECK) |
| A new user is registered with Active status, 0 failed attempts, and N (not locked) by default. | Procedure logic (Register_User) |
| There is no fixed ratio or required count of Admins, Trainers, or Players. | Not enforced — a deliberate design choice, not a constraint |

## 2. Challenges

| Rule | Enforcement |
|---|---|
| Each challenge belongs to exactly one category. | Database constraint (Challenges.Category_ID FK) |
| A challenge's point value must be greater than zero. | Database constraint (CHECK) |
| A challenge's maximum attempts cannot be negative; 0 means unlimited attempts. | Database constraint (CHECK) + procedure logic (Submit_Flag) |
| Only users with the Admin or Trainer role may create a challenge. | Procedure logic (Create_Challenge) |
| A challenge's status must be Active or Inactive. | Database constraint (CHECK) |

## 3. Hints

| Rule | Enforcement |
|---|---|
| Each hint belongs to exactly one challenge. | Database constraint (FK) |
| A hint's point cost cannot be negative. | Database constraint (CHECK) |
| A hint may only be added to a challenge that is currently Active. | Procedure logic (Add_Hint) |

## 4. Submissions

| Rule | Enforcement |
|---|---|
| A submission must reference an existing user and an existing challenge. | Database constraint (FK) |
| Is_Correct must be Y or N. | Database constraint (CHECK) |
| Score awarded cannot be negative. | Database constraint (CHECK) |
| A correct submission awards the challenge's full point value; an incorrect submission awards zero. | Procedure logic (Submit_Flag) |
| A submission is only accepted if the submitting user's account is Active. | Procedure logic (Submit_Flag) |
| A submission is only accepted if the target challenge is Active. | Procedure logic (Submit_Flag) |
| A user cannot exceed a challenge's maximum attempts (unless unlimited). | Procedure logic (Submit_Flag) |
| Every new submission is automatically recorded in the audit trail. | Trigger (TRG_AUDIT_SUBMISSIONS) |
| Hint usage does not automatically deduct points from a submission's score. | Not enforced — a deliberate simplification, not a constraint |

## 5. Teams

| Rule | Enforcement |
|---|---|
| Each team has exactly one leader, who must be an existing user. | Database constraint (FK) |
| A user may belong to at most one team. | Procedure logic (Assign_Team) — not a table-level constraint |
| A team's leader is not required to also be a member of that team. | Not enforced — a deliberate design choice, not a constraint |
| A team leader is not required to hold any specific role (Admin, Trainer, or Player). | Not enforced — a deliberate design choice, not a constraint |

## 6. Training Sessions

| Rule | Enforcement |
|---|---|
| Each session is led by exactly one trainer, who must be an existing user. | Database constraint (FK) |
| A session's duration must be greater than zero minutes. | Database constraint (CHECK) |
| A user's attendance status must be Registered, Attended, or Absent. | Database constraint (CHECK) |

## 7. Auditing

| Rule | Enforcement |
|---|---|
| Every new submission is logged automatically, without requiring the application to write the audit record explicitly. | Trigger (TRG_AUDIT_SUBMISSIONS) |
| An audit log entry is not required to reference a user (e.g. system-level events). | Database constraint (User_ID is nullable) |

---

## Notes on Design Decisions

A few rules were deliberately *not* enforced at the database level, even
though they could have been:

- *One team per user* is checked in the Assign_Team procedure rather
  than with a UNIQUE constraint on Team_Members.User_ID, since Team
  membership is only guaranteed consistent when data goes through the
  procedure — direct INSERT statements bypass this check.
- *Team leader role and membership* are intentionally left flexible: a
  leader does not have to be a Player, and does not have to appear in
  Team_Members. Enforcing either would require an additional constraint
  or trigger that this project does not implement.
- *Role distribution* (e.g. requiring a minimum/maximum number of
  Admins) is not restricted; the sample data reflects a chosen mix rather
  than a rule the schema enforces.

These are documented here so the gap between "what the schema allows" and
"what the sample data happens to look like" is explicit, rather than left
for a reader to guess at.
