-- Calculate various metrics for all teams
WITH team_calculations AS (
	SELECT Team, games AS GamesPlayed
		, ROUND(points_scored / games, 2) AS PointsPerGame
        , ROUND((passing_touchdowns + rushing_touchdowns) / games, 2) AS TDsPerGame
		, ROUND(total_yards / games, 0) AS YardsPerGame
        , ROUND(total_yards / offensive_plays, 2) AS YardsPerPlay
        , ROUND(passing_yards / passes_attempted, 2) AS PassYardsPerAttempt
        , ROUND(rushing_yards / rushing_attempts, 2) AS RushYardsPerAttempt
        , ROUND(passing_touchdowns / interceptions, 2) AS TDtoINTratio
        , ROUND(turnovers_lost / games, 2) AS TurnoversPerGame
    FROM nfloffense_2022
)
--  Display team metrics and rank from highest to lowest
SELECT Team
	, GamesPlayed
	, PointsPerGame, RANK() OVER (ORDER BY PointsPerGame DESC) AS PointsRank
    , TDsPerGame, RANK() OVER (ORDER BY TDsPerGame DESC) AS TDsRank
    , YardsPerGame, RANK() OVER (ORDER BY YardsPerGame DESC) AS GameYardsRank
    , YardsPerPlay, RANK() OVER (ORDER BY YardsPerPlay DESC) AS PlayYardsRank
    , PassYardsPerAttempt, RANK() OVER (ORDER BY PassYardsPerAttempt DESC) AS PYperAttRank
    , RushYardsPerAttempt, RANK() OVER (ORDER BY RushYardsPerAttempt DESC) AS RYperAttRank
    , TDtoINTratio, RANK() OVER (ORDER BY TDtoINTratio DESC) AS PassRatioRank
    , TurnoversPerGame, RANK() OVER (ORDER BY TurnoversPerGame) AS TurnoversRank
FROM team_calculations
ORDER BY PointsRank;