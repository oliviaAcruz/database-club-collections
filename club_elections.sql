-- ── Club Members ────────────────────────────────────
-- Drop first so you can re-run this script cleanly.
DROP TABLE IF EXISTS votes;
DROP TABLE IF EXISTS clubMembers;

CREATE TABLE clubMembers (
    id            INTEGER PRIMARY KEY,
    name          TEXT    NOT NULL,
    grade         INTEGER NOT NULL,
    favoriteColor TEXT
);

INSERT INTO clubMembers (id, name, grade, favoriteColor) VALUES
    (1, 'Alice',  10, 'red'),
    (2, 'Beth',   11, 'blue'),
    (3, 'Carlos', 10, 'green'),
    (4, 'Dana',   12, 'blue'),
    (5, 'Eli',    11, NULL),
    (6, 'Fay',    10, 'red'),
    (7, 'Grace',  12, 'purple'),
    (8, 'Hank',   11, NULL);

-- ── Votes ───────────────────────────────────────────
-- voterId     = the member casting the vote
-- candidateId = the member they voted for
-- Grace (7) and Hank (8) did not vote.
CREATE TABLE votes (
    id          INTEGER PRIMARY KEY AUTOINCREMENT,
    voterId     INTEGER NOT NULL,
    candidateId INTEGER NOT NULL,
    FOREIGN KEY (voterId)     REFERENCES clubMembers(id),
    FOREIGN KEY (candidateId) REFERENCES clubMembers(id)
);

INSERT INTO votes (voterId, candidateId) VALUES
    (1, 2),  -- Alice  -> Beth
    (2, 2),  -- Beth   -> Beth
    (3, 4),  -- Carlos -> Dana
    (4, 4),  -- Dana   -> Dana
    (5, 2),  -- Eli    -> Beth
    (6, 7);  -- Fay    -> Grace
    
    
-- MEMBER QUESTIONS
-- 1. Who is member #5?
SELECT name FROM clubMembers WHERE id = 5;
-- expected result: Eli (true)

-- 2. What is their favorite color?
SELECT favoriteColor FROM clubMembers WHERE id = 5;
-- expected result: Null (true)

-- 3. Whose favorite color is blue?
SELECT name FROM clubMembers WHERE favoriteColor = 'blue';
-- expected result: Beth, Dana (true)

-- 4. Who doesn't have a favorite color? 
SELECT name FROM clubMembers WHERE favoriteColor IS NULL; 
-- expected result: Eli, Hank (true)

-- 5. How many members are there? 
SELECT COUNT(name) FROM clubMembers;
-- expected result: 8 (true)

-- 6. How many are in 10th grade?
SELECT COUNT(name) FROM clubMembers WHERE grade = 10; 
-- expected result: 3 (true)

-- VOTING QUESTIONS 
-- 7. Who did member #6 vote for?
SELECT candidateId FROM votes WHERE voterId = 6;
-- expected result: 7 (true)

-- 8. Who did Beth vote for?
SELECT candidateId FROM votes WHERE voterId = 2;
-- expected result: Beth (true)

-- 9. Who voted for Beth?
SELECT voterId FROM votes where candidateId = 2; 
-- expected result: 1, 2, 5 (true)

-- 10. Who voted for themselves?
SELECT voterId from votes WHERE candidateId = voterId; 
-- expected result: 2, 4(true)

-- 11. Who didn't vote?
SELECT id from clubMembers except select voterId from votes;
-- expected result; 7,8 (true)

-- 12. What are the election results (candidate + vote count?)
SELECT candidateId, COUNT(candidateId) AS total FROM votes 
GROUP BY candidateId 
ORDER BY total DESC; 

-- 13. Who won?
SELECT candidateId, COUNT(candidateId) AS total FROM votes
GRoup by candidateId 
ORDER BY total DESC 
LIMIT 1;
-- expected result: 2 with 3 votes (true)

-- DATA OPERATIONS 
-- 14. Add isabel (id 9, grade 8, favorite color purple)
INSERT INTO clubMembers (id, name, grade, favoriteColor) 
VALUES (9, 'isabel', 8, 'purple');

-- 15. Record that Isabel voted for Beth

INSERT INTO votes (voterId, candidateId)
VALUES (9, 2);

-- 16. Change Isabel's vote to Dana
Update votes set candidateId = 4 where voterId = 9;

-- 17. Remove Isabel's vote 
delete from votes where voterId = 9;