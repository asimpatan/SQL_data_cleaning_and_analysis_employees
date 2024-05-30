/****** Script for SelectTopNRows command from SSMS  ******/
SELECT TOP (1000) *
  FROM [employee_salaries_project].[dbo].[emp_dataset]

select * from emp_dataset e
left join employees emp
on emp.comp_code_emp = e.comp_code

SELECT COUNT(*) FROM employees; --1119
SELECT COUNT(*) FROM companies; --25
SELECT COUNT(*) FROM salaries; --8049
SELECT COUNT(*) FROM functions; --107

--to check presence age,gender values
SELECT e.employee_code_emp,e.employee_name_emp,e.GEN_M_F,e.age,ed.age FROM employees e
join emp_dataset ed
on e.employee_code_emp =ed.employee_id


SELECT * FROM employees 
WHERE employees.employee_name_emp ='Lucas Ward'