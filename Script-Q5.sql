SELECT 
	tm.payroll_year,
	ROUND (avg(tm.average_value),2) AS 'average_value',
	ROUND (avg(tm.average_pay),2) AS 'average_pay',
	tm2.GDP AS 'HDP'
FROM t_michala_pavlisova_project_SQL_primary_final tm
JOIN t_michala_pavlisova_project_SQL_secondary_final tm2 ON tm.payroll_year =tm2.`year`
GROUP BY tm2.`year`;