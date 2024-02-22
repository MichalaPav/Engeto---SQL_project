SELECT 
	payroll_year,
	price_year,
	name_category,
	average_pay,
	average_value,
	FLOOR(average_pay / average_value) AS quantity
FROM t_michala_pavlisova_project_SQL_primary_final tmppspf 
WHERE name_category IN ('Mléko polotučné pasterované', 'Chléb konzumní kmínový')
	AND price_year IN (2006, 2018)
GROUP BY name_category, payroll_year;  