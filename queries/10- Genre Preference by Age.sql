/*Genre Preference by Age using Group By and Having: Determine the preferred genre of different age groups of borrowers. (Groups are (0,10), (11,20), (21,30)…)*/
WITH AgeIntervalsWithBooks AS (
    SELECT
        l.BookID,
        FLOOR(DATEDIFF(YEAR, b.[Date Of Birth], GETDATE()) / 10) * 10 + 1 AS startInterval,
        FLOOR(DATEDIFF(YEAR, b.[Date Of Birth], GETDATE()) / 10) * 10 + 10 AS endInterval
    FROM Loans l
    INNER JOIN Borrowers b ON l.BorrowerID = b.BorrowerID
),
GenreCount AS (
    SELECT
        COUNT(*) AS GenreCount,
        CONCAT(ai.startInterval, '-', ai.endInterval) AS AgeInterval,
		b.genre as GenreName
    FROM AgeIntervalsWithBooks ai
    INNER JOIN Books b ON ai.BookID = b.BookID
    GROUP BY CONCAT(ai.startInterval, '-', ai.endInterval), b.genre
),

MaxGenrePerInterval AS (
    SELECT
        AgeInterval,
        MAX(GenreCount) AS MaxGenreCount
    FROM GenreCount
    GROUP BY AgeInterval
)
SELECT 
    gc.AgeInterval,
    gc.GenreName,
    gc.GenreCount
FROM GenreCount gc
INNER JOIN MaxGenrePerInterval mg
    ON gc.AgeInterval = mg.AgeInterval
   AND gc.GenreCount = mg.MaxGenreCount
ORDER BY gc.AgeInterval;



