--How experienced is our engineering team?
select * from df_employee where function_group like 'Engineering'
--MS SQL queries to address the concerns related to analyzing the experience level of the engineering team:
--1.Calculate Employee Tenure:
SELECT employee_id,
    DATEDIFF(MONTH, MIN(month_year), GETDATE()) AS months_tenure
FROM df_employee
WHERE function_group = 'Engineering'
GROUP BY employee_id; --all emp->20-27yrs months_tenure
--2.Assess Age Distribution:
SELECT 
    AVG(age) AS avg_age,
    MIN(age) AS min_age,
    MAX(age) AS max_age
FROM df_employee
WHERE function_group = 'Engineering';
/* o/p: avg_age	min_age	max_age
24	18	38   */
--3.Evaluate Salary Trends:
SELECT 
    AVG(salary) AS avg_salary,
    MIN(salary) AS min_salary,
    MAX(salary) AS max_salary
FROM df_employee
WHERE function_group = 'Engineering';
/*o/p: avg_salary	min_salary	max_salary
109889.383419689	3000	326667  */
--4.Consider Role Changes:
SELECT 
    employee_id,
    COUNT(DISTINCT function_group) AS role_changes
FROM 
    df_employee
GROUP BY employee_id
HAVING COUNT(DISTINCT function_group) > 1;
-- no role changes.no potential career progression and experience accumulation.
--5 Review Qualifications and Training:
--SELECT 
--    employee_id,
--    qualification,
--    training_completed
--FROM employee_qualifications
--WHERE 
--    employee_id IN (SELECT DISTINCT employee_id FROM df_employee WHERE function_group = 'Engineering');



/* insights:
we can infer the following insights regarding the experience level of the engineering team:

Employee Tenure:
All employees in the engineering team have a tenure ranging from 20 to 27 years in months, indicating a relatively stable workforce with significant experience within the organization.
Age Distribution:
The average age of employees in the engineering team is 24 years, with the youngest employee being 18 years old and the oldest being 38 years old. This suggests a diverse age range within the team, with a mix of junior and experienced professionals.
Salary Trends:
The average salary within the engineering team is $109,889.38, with salaries ranging from $3,000 to $326,667. This wide salary range may indicate varying levels of experience, expertise, and seniority among team members.
Role Changes:
No employees have changed roles within the engineering function based on the available data. While this limits the assessment of potential career progression and experience accumulation within the team, the stable role tenure may suggest a focused and experienced workforce in their current positions.
Qualifications and Training:
Unfortunately, there is no data available for analyzing qualifications and training completed by employees in the engineering team. Therefore, we cannot assess the level of expertise or specialization based on this aspect.
Overall, based on the available data, the engineering team appears to be experienced, with a stable workforce and a diverse age range. The wide salary range suggests varying levels of experience and expertise among team members, contributing to a dynamic and skilled workforce within the organization. However, further insights could be gained with additional data on qualifications, training, and potential career progression within the team.

*/
