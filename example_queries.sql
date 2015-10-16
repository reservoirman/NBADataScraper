#find the average number of games Carmelo Anthony missed over the last three seasons:

SELECT AVG(DNP.Count)
FROM DidNotPlay DNP
WHERE DNP.PID = (SELECT P.PID FROM Players P WHERE P.PlayerName = "Carmelo Anthony")
AND DNP.SeasonYear >= 2013;

#Result: Melo missed an average 20.67 games per season over the last three seasons.
20.6667

#list the points and season year for every game that Stephen Curry scored at least 50 points on the Knicks in New York over the last 5 seasons
SELECT G.SeasonYear, (I.Pts)
FROM IndPerf I, Games G
WHERE I.PID = (SELECT P.PID FROM Players P WHERE P.PlayerName = "Stephen Curry")
AND (G.Home…TID = (SELECT B.TID FROM BelongsTo B WHERE B.TeamName = "New York Knicks" AND B.SeasonYear = 2015))
AND G.GameID = I.GameID;

#Result: it happened once, in the 2012-2013 season:
2013	54


#fnd the list of all players who scored at least 50 points in a game during the 2013-2014 season:
SELECT DISTINCT P.PlayerName
FROM Players P, IndPerf I, Games G
WHERE G.SeasonYear = 2014 AND G.GameID = I.GameID AND I.Pts >= 50 AND P.PID = I.PID;

#result:
Kevin Durant
Carmelo Anthony
Terrence Ross
LeBron James
Corey Brewer