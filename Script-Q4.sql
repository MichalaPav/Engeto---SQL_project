WITH change_pay AS (
	SELECT 
		tm.payroll_year AS year,
		tm.average_pay AS average_pay_last_year,
		tm2.average_pay AS average_pay,
		ROUND((((avg(tm.average_pay))-(avg(tm2.average_pay)))/avg(tm2.average_pay))*100,2) AS 'year_change'
	FROM t_michala_pavlisova_project_SQL_primary_final tm
	JOIN t_michala_pavlisova_project_SQL_primary_final tm2 ON tm.payroll_year = tm2.payroll_year+1
	GROUP BY tm.payroll_year 
	),
	change_price AS (
	SELECT
		tm.price_year AS year,
		tm.average_value AS average_value_last_year,
		tm2.average_value AS average_value,
		ROUND((((avg(tm.average_value))-(avg(tm2.average_value)))/avg(tm2.average_value))*100,2) AS 'year_change_value'
	FROM t_michala_pavlisova_project_SQL_primary_final tm
	JOIN t_michala_pavlisova_project_SQL_primary_final tm2 ON tm.price_year = tm2.price_year+1
	GROUP BY tm.price_year
	)
SELECT
	tm.payroll_year AS year,
	year_change,
	year_change_value,
	year_change-year_change_value AS diff
FROM t_michala_pavlisova_project_SQL_primary_final tm
JOIN change_pay cp ON tm.payroll_year =cp.year
JOIN change_price cpp ON tm.price_year=cpp.year
GROUP BY tm.payroll_year
ORDER BY diff;