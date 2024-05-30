/****** Script for SelectTopNRows command from SSMS  ******/
SELECT TOP (1000) [comp_code_emp]
      ,[employee_code_emp]
      ,[employee_name_emp]
      ,[GEN_M_F]
      ,[age]
  FROM [employee_salaries_project].[dbo].[employees]
  
--TEXT EMPLOYEE COMPANY CODES 
  SELECT * FROM employees WHERE ISNUMERIC(comp_code_emp)=0

-- creating new tbl with only company codes_emp text
SELECT * INTO txt_emp_company_codes
FROM employees WHERE ISNUMERIC(comp_code_emp)=0

SELECT * FROM txt_emp_company_codes

--deleting TEXT EMPLOYEE COMPANY CODES  from employees table
delete FROM employees WHERE ISNUMERIC(comp_code_emp)=0  