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