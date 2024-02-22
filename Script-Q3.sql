SELECT 
	DISTINCT tm.price_year AS YEAR,
	tm.name_category AS food,
	((tm.average_value-tm2.average_value)/tm2.average_value)*100 AS 'variation'
FROM t_michala_pavlisova_project_SQL_primary_final tm
JOIN t_michala_pavlisova_project_SQL_primary_final tm2 
	ON tm.price_year = tm2.price_year+1 
	AND tm.name_category = tm2.name_category
ORDER BY variation;