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