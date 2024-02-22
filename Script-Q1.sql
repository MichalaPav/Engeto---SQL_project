SELECT 
	DISTINCT tm.payroll_year,
	tm. name_industry,
	tm.industry_branch_code,
	tm.average_pay,
	tm2.average_pay,
	CASE
		WHEN tm.average_pay > tm2.average_pay THEN 'grow'
		WHEN tm.average_pay < tm2.average_pay THEN 'decline'
		ELSE 0
	END AS 'score'
FROM t_michala_pavlisova_project_SQL_primary_final AS tm
JOIN 
(
	SELECT 
		tm2.payroll_year,
		tm2. name_industry,
		tm2.industry_branch_code,
		tm2.average_pay
	FROM t_michala_pavlisova_project_SQL_primary_final AS tm2 
	) tm2
ON tm.payroll_year = tm2.payroll_year+1 AND tm.industry_branch_code = tm2.industry_branch_code
ORDER BY score, payroll_year;