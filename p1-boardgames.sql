-- count mechanics 
	-- temporary table to separate mechanics
	create temporary table numbers as (
 select 1 as n union 
 select 2 as n union 
 select 4 as n union 
 select 5 as n union 
 select 6 as n union 
 select 7 as n union 
 select 8 as n union 
 select 9 as n union 
 select 10 as n union 
 select 11 as n union 
 select 12 as n union 
 select 13 as n union 
 select 14 as n union 
 select 15 as n union 
 select 16 as n union 
 select 17 as n union 
 select 18 as n union
 select 19 as n)

-- Game mechanics stats table
WITH mech_rank AS (
	SELECT CASE WHEN Mechanics = '' THEN 'Uncategorized'
    ELSE TRIM(SUBSTRING_INDEX(SUBSTRING_INDEX(Mechanics, ",", n),',', -1)) END AS mechanics,
    `Rating Average`,
    `Complexity Average`,
    `Min Players`,
    `Max Players`,
    `Play Time`
	FROM bgg_data_set 
		JOIN numbers ON LENGTH(Mechanics) - LENGTH(REPLACE(Mechanics, ',', '')) >= n - 1)
SELECT 
	mechanics,
	COUNT(mechanics) AS num_mech,
	ROUND(AVG(`Rating Average`),2) AS avg_rating,
	ROUND(AVG(`Complexity Average`),2) AS avg_complexity,
    ROUND(AVG(`Min Players`),2) AS avg_min_players,
    ROUND(AVG(`Max Players`),2) AS avg_max_players,
    ROUND(AVG(`Play Time`),2)/60 AS avg_playtime
FROM mech_rank
GROUP BY mechanics
ORDER BY avg_rating DESC

-- Games by year stats
mechanics_statsCREATE TABLE year_stats
SELECT
	`Year Published` AS year,
    COUNT(ID) AS num_games,
    ROUND(AVG(`Rating Average`),2) AS avg_rating,
	ROUND(AVG(`Complexity Average`),2) AS avg_complexity,
    ROUND(AVG(`Min Players`),2) AS avg_min_players,
    ROUND(AVG(`Max Players`),2) AS avg_max_players,
    ROUND(AVG(`Play Time`)/60,2) AS avg_playtime
FROM bgg_data_set
GROUP BY year
ORDER BY year DESC

