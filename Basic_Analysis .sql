-- Analyze the Data
select * from df_employee
--What is the average of salaries by month?”
	--adding new column
	alter table df_employee
	add pay_month varchar(7); 
	--now assigning data
	SELECT left(month_year, 7) AS yyyy_mm FROM df_employee;
	update df_employee set pay_month = left(month_year, 7)--substring(id,6, 7)
select pay_month,avg(salary) as avg_salary
from df_employee group by pay_month
--2.-- How many employees do the companies have today?

select comp_name,COUNT(distinct employee_id) as No_of_Emp
from df_employee
where pay_month=(select MAX(pay_month) from df_employee) 
group by comp_name,pay_month
ORDER BY No_of_Emp DESC
/*o/p: The Crossings at Falcon Point	107
Regional Hospital	82 */

-- What is the total no.of employees each city? Add a percentage column
select company_city,COUNT(distinct employee_id) as emp_cnt,
	COUNT(distinct employee_id)*100.0 AS EMP_CNT_PER_CITY,
	(SELECT COUNT(distinct employee_id) FROM df_employee) AS TOT_,
	COUNT(distinct employee_id)*100.0/
	(SELECT COUNT(distinct employee_id) FROM df_employee)  as percentage_
from df_employee
group by company_city
order by emp_cnt desc
/*company_city	emp_cnt	percentage_
Goiania	693	62.096774193548
Brasilia	371	33.243727598566
Palmas	50	4.480286738351
Goianiaa	2	0.179211469534  */

---What is the total number of employees each month?
select pay_month,COUNT(distinct employee_id) as No_of_Emp
from df_employee
--where pay_month=(select MAX(pay_month) from df_employee) 
group by pay_month
ORDER BY No_of_Emp DESC

-- What is the average number of employees each month?
select COUNT(employee_id)/COUNT(distinct pay_month) as AVG_EMP
from df_employee
--What is the minimum and maximum number of employees throughout all the months? In which months were they? 493 631
select PAY_MONTH, 
		MIN(COUNT(employee_id)) OVER(), 
		MAX(COUNT(employee_id)) OVER()
from df_employee GROUP BY pay_month

-- What is the monthly average number of employees by function group?
SELECT 
    function_group,
	YEAR(month_year) as year,
	MONTH(month_year) month,
	avg(count(distinct employee_id)) 
		over(partition by function_group,
			YEAR(month_year),
			MONTH(month_year)) as avg_emp_cnt
	from df_employee
	group by function_group,YEAR(month_year),MONTH(month_year)
 
------What is the annual average salary?
select	year(month_year),
		AVG(salary) as annual_avg_salary
from df_employee
group by year(month_year)
order by year(month_year)
---What is the monthly average salary?
select	year(month_year),month(month_year),
		AVG(salary) as monthly_avg_salary
from df_employee
group by year(month_year),month(month_year)
order by year(month_year),month(month_year)
--- What is the average salary by city?
select	company_state,company_city,
		AVG(salary) as annual_avg_salary
from df_employee
group by company_state,company_city
order by company_state,company_city

-- What is the  average salary by function group?
select function_group,
round( AVG(salary), 2) as avg_salary
from df_employee
group by function_group 

-- What are the employees with the top 10 highest salaries in average?
select top 10 employee_name,
		AVG(salary) avg_Salary
from df_employee
group by employee_name
order by AVG(salary) desc