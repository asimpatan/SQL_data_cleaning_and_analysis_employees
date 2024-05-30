 IF NOT EXISTS(
	SELECT 1 FROM sys.databases WHERE					name='employee_salaries_project')
	CREATE DATABASE employee_salaries_project  --DB NAME

--IF NOT EXISTS(
--	SELECT 1 FROM INFORMATION_SCHEMA.TABLES 
--		WHERE TABLE_SCHEMA='' AND  TABLE_NAME=''

--****** Data Cleaning *********--
-- Create Temporary Datasets( as not to mess with original huge data)
--8049 rows affected for new table 
--(x) when you map with s.comp_code-5218440 rows affected
SELECT * INTO emp_dataset  
FROM salaries s 
LEFT JOIN companies c ON s.comp_name=c.company_name
LEFT JOIN functions f ON s.func_code = f.function_code
LEFT JOIN employees e ON s.employee_id=e.comp_code_emp
---------------------------------------------
SELECT COUNT(*) FROM emp_dataset --8049
--create staging table to do data clean
SELECT e.employee_code_emp,e.employee_name_emp,e.GEN_M_F,e.age,ed.age FROM employees e
join emp_dataset ed
on e.employee_code_emp =ed.employee_id

-- Select only relevant columns for further analysis
-- Create an unique identifier code between the columns 'employee_id' and 'date' and call it 'id'
-- Convert the column 'date' to DATE type because it was previously configured as TIMESTAMP
-- Transform this new table into a dataset (df_employee) for analysis
SELECT * from emp_dataset 
--------------------------------------------------
-- tbl: df_employee rows: 8049
select concat(employee_id,CAST(date as date) ) as id,
	CAST(date as date) as month_year,
	employee_id,
	employee_name,
	[GEN_M_F],
	age,
	salary,function_group,func_code,
	comp_name,company_city,company_state,company_type
	const_site_category
	INTO df_employee
from emp_dataset

--filling missing detials from employees tbl->df_employee----
SELECT * from df_employee --8049
SELECT e.GEN_M_F,df.GEN_M_F,df.GEN_M_F from df_employee df
left join employees e 
on df.employee_id =e.employee_code_emp --[innerjoin-7705,leftjoin-8049]
--JOIN emp_dataset ed ON df.employee_id = ed.employee_id --74371
--gender
update df_employee
set GEN_M_F=e.GEN_M_F
from df_employee df
left join employees e 
on df.employee_id =e.employee_code_emp
---age
update df_employee
set age=e.age
from df_employee df
left join employees e 
on df.employee_id =e.employee_code_emp
---------Check Data Quality---------------------
/*Now it’s time to check the data quality to ensure the quality of the analysis.After performing a quick visual analysis, we identified some problems that need to be corrected. */

SELECT * from df_employee
--rename gender column
sp_rename 'df_employee.[GEN_M_F]','gender','COLUMN'
--TRIM, to remove unwanted spaces FOR STRINGS ONLY,(NO NUMERIC,DATETYPES)
update df_employee
set id=trim(id),
	--employee_id=TRIM(employee_id),
	employee_name=TRIM(employee_name),
	gender=trim(gender),
	function_group=TRIM(function_group),
	comp_name=TRIM(comp_name),
	company_city=TRIM(company_city),
	company_state=TRIM(company_state),
	const_site_category=TRIM(const_site_category)--8049 DONE
--Check for ‘null’ values----
SELECT * FROM df_employee
 WHERE id IS NULL
 OR CAST(month_year AS varchar) IS NULL
 OR employee_id IS NULL
 OR employee_name IS NULL
 OR gender IS NULL
 OR age IS NULL
 OR salary IS NULL
 OR function_group IS NULL
 OR comp_name IS NULL
 OR company_city IS NULL
 OR company_state IS NULL  --403
 -----COALESCE -func not handling properly so above query Use.
 SELECT * FROM df_employee
WHERE COALESCE(CAST(id AS VARCHAR(52)) , CAST(month_year AS VARCHAR), employee_id, employee_name, gender, cast(age as varchar), CAST(salary AS VARCHAR), function_group, comp_name, company_city, company_state, const_site_category) IS NULL;
----delete null values ------
DELETE FROM df_employee  --403 rows affected
 WHERE id IS NULL
 OR CAST(month_year AS varchar) IS NULL
 OR employee_id IS NULL
 OR employee_name IS NULL
 OR gender IS NULL
 OR age IS NULL
 OR salary IS NULL
 OR function_group IS NULL
 OR comp_name IS NULL
 OR company_city IS NULL
 OR company_state IS NULL
 ---missing values delete----
  SELECT COUNT(salary) FROM df_employee WHERE salary like '';
  SELECT * FROM df_employee WHERE const_site_category like '';
 
 /****----standardization-----****/
 select case when gender like 'F' then 'Female' 
			 when gender like 'M' then 'Male' 
		end 
from df_employee
--update df_employee 
--	set gender =
--	(case	when gender like 'F' then 'Female' 
--			when gender like 'M' then 'Male' 
--	end )
select * from df_employee --7461 rows
--company state
--1st,new word start upper and other lower format
SELECT UPPER(LEFT(company_state, 1)) + LOWER(SUBSTRING(company_state, 2, CHARINDEX(' ', company_state + ' ', 2) - 2)) +
       UPPER(SUBSTRING(company_state, CHARINDEX(' ', company_state + ' ', 2) + 1, 1)) +
       LOWER(SUBSTRING(company_state, CHARINDEX(' ', company_state + ' ', 2) + 2, LEN(company_state)))
from df_employee;
--format updated for company_State to pascal case
UPDATE df_employee 
SET company_state = 
    UPPER(LEFT(company_state, 1)) + 
    LOWER(SUBSTRING(company_state, 2, CHARINDEX(' ', company_state + ' ', 2) - 2)) +
    UPPER(SUBSTRING(company_state, CHARINDEX(' ', company_state + ' ', 2) + 1, 1)) +
    LOWER(SUBSTRING(company_state, CHARINDEX(' ', company_state + ' ', 2) + 2, LEN(company_state)))
select distinct(company_state) from df_employee;
	
/*---------------removing duplicates if present ------------- */
select distinct id,COUNT(id) duplicate_id from df_employee
group by id having COUNT(id)>1 --185

--with cte   --185
with cte as (
	select *,
	row_number() over(partition by id order by id desc) as duplicate_id 
	from df_employee)
select id from cte where duplicate_id>1
---deleting duplicate rows  --185 rows affected
with cte as (
	select *,
	row_number() over(partition by id order by id desc) as duplicate_id 
	from df_employee)
delete from cte where duplicate_id>1
--------------
select * from df_employee
select distinct (function_group) from df_employee



SELECT 
    company_city,
    COUNT(DISTINCT employee_id) AS emp_cnt,
    100.0 * COUNT(DISTINCT employee_id) / (SELECT COUNT(DISTINCT employee_id) FROM df_employee) AS percentage_
FROM 
    df_employee
GROUP BY 
    company_city
ORDER BY 
    emp_cnt DESC;
