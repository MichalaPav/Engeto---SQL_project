-- pro vytvoření finální tabulky jsem se rozhodla vytvořit dvě samostatné tabulky, které spojím v jednu finální

-- následující příkazy mi slouží ke zjištění průniku roků

SELECT *
FROM czechia_payroll cp
ORDER BY payroll_year DESC; 

SELECT *
FROM czechia_payroll cp
ORDER BY payroll_year;

SELECT *
FROM czechia_price cp 
ORDER BY date_from DESC;

SELECT *
FROM czechia_price cp 
ORDER BY date_from;

CREATE TABLE t_payroll AS (
SELECT
	cp.payroll_year AS payroll_year,
	cpib.name AS name_industry,
	ROUND(avg(cp.value)) AS average_pay,
	value_type_code,
	industry_branch_code,
	calculation_code
FROM czechia_payroll cp 
JOIN czechia_payroll_calculation AS cpc
ON cp.calculation_code = cpc.code
JOIN czechia_payroll_industry_branch cpib 
	ON cp.industry_branch_code = cpib.code
WHERE cp.value IS NOT NULL AND value_type_code = 5958
	AND cp.payroll_year BETWEEN 2006 AND 2018
GROUP BY cp.payroll_year, cpib.name
);

CREATE TABLE t_price AS (
SELECT
	cpc.name AS name_category,
	ROUND(avg(cp.value),2) AS average_value,
	cpc.price_value AS amount,
	cpc.price_unit AS unit,
	YEAR (cp.date_from) AS price_year,
	cp.category_code
FROM czechia_price cp 
JOIN czechia_price_category cpc 
	ON cp.category_code = cpc.code
WHERE cp.region_code IS NULL 
GROUP BY YEAR(cp.date_from), cpc.name
);

-- final table
CREATE TABLE t_michala_pavlisova_project_SQL_primary_final AS (
SELECT *
FROM t_payroll tp 
JOIN t_price tp2 
	ON tp.payroll_year = tp2.price_year
);