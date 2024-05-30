The CEO of the group of companies where I work has requested an analysis of all employees on the construction sites since January 2022.   
This group of companies includes a real estate developer and construction company, as well as separate administrative offices and construction sites that are treated as individual companies.    
The group operates in different cities in 3 states of Brazil. In a meeting, some questions were defined to be answered:      

Has the average salary decreased or increased since January 2022?      
How effective is our HR program to reduce the gender gap?      
How are our salaries distributed across the states?    
How standardized is our pay policy across the states?      
How experienced is our engineering team?      
In what function groups do we spend the most?      
What construction sites spent the most in salaries for the period?      
He also asked for some recommendations if something needed to be pursued by the company appears.

## 1. Has the average salary decreased or increased since January 2022?
![Q1 SQL QUERY](https://github.com/asimpatan/SQL_data_cleaning_and_analysis_employees/blob/main/Q1.PNG)
![Q1 Solution](https://github.com/asimpatan/SQL_data_cleaning_and_analysis_employees/blob/main/Q1_output.PNG)

/* insights:
	the average salary has increased since January 2022.
add info:
The average salary shows an increasing trend from January 2022 to January 2023.
In January 2022, the average salary was 21,836 units, and it steadily increased over the months, reaching 69,391 units in January 2023.
This suggests that the average salary has increased over the specified period, indicating potential growth or changes in compensation practices within the organization.
In summary, based on the query output, the average salary has increased since January 2022.
*/

## 2.How effective is our HR program to reduce the gender gap?
select year(month_year), gender,COUNT(id)as epm_cnt,
	COUNT(distinct id) per_group,
	(select COUNT(distinct id) from df_employee ) total_,
	COUNT(distinct id)*100.0/
		(select COUNT(distinct id) from df_employee ) as '%change'
from df_employee
group by year(month_year),gender
order by epm_cnt
/*o/p:
(No column name)	gender	epm_cnt	per_group	total_	%change
2023	Female	214	214	7461	2.868248224098
2023	Male	409	409	7461	5.481838895590
2022	Female	792	792	7461	10.615199034981
2022	Male	6046	6046	7461	81.034713845329  */

/* insights:
In 2022, there was a significant gender gap in the employee distribution, with male employees comprising 81.03% of the workforce, compared to only 10.62% female employees.
However, by 2023, there was a noticeable reduction in the gender gap. Male employees decreased to 5.48% of the workforce, while female employees increased to 2.87%.
This indicates a positive trend towards a more balanced gender representation within the organization.

Implication:
	The HR program implemented between 2022 and 2023 appears to have had a positive effect on reducing the gender gap.
	The increase in female employee representation suggests that the HR initiatives aimed at promoting gender diversity and inclusion may be yielding results.
	However, it's important to continue monitoring and evaluating the effectiveness of these initiatives to ensure sustained progress towards gender equality.
Recommendation:
	Based on the observed trend, it would be beneficial for the organization to continue investing in HR programs and initiatives that promote gender diversity and inclusion.
	Regular reviews and assessments of these programs are essential to identify areas for improvement and ensure that progress towards gender equality is sustained over time.
Conclusion:
	While there has been progress in reducing the gender gap, achieving full gender equality requires ongoing commitment and effort from the organization.
	By continuing to prioritize diversity and inclusion in HR policies and practices, the organization can create a more equitable and inclusive workplace for all employees.
*/

## 3:How are our salaries distributed across the states?

--1.with resp. Understanding the average salary levels across states
select company_state,
		cast(AVG(salary) as int) avg_salary
from df_employee
group by company_state
order by avg_salary
/* o/p:
company_state	avg_salary
DistritoFederal	33484
Goias	54249
Tocantins	72079 */

/*Insights:
Salary Disparity: 
	There is significant disparity in average salaries across the analyzed states, with Tocantins having the highest average salary, followed by Goias, and then DistritoFederal.
Regional Variations: 
	The data highlights regional variations in compensation levels, with Tocantins potentially offering more lucrative opportunities compared to Goias and DistritoFederal.
Strategic Considerations: 
	Understanding these salary discrepancies can inform strategic decisions related to talent acquisition, resource allocation, and business expansion in different regions.
Competitive Landscape: 
	Employers operating in these states should be mindful of local salary norms and competitive pressures to attract and retain top talent.
These insights provide valuable context for workforce planning and organizational decision-making, helping businesses tailor their strategies to effectively navigate the diverse salary landscapes across different states.

add info:
The choice between these two methods depends on the specific objectives of your analysis and the insights you're looking to gain. 
	If you're interested in understanding the average salary levels across states, the average salary approach is more suitable.
      On the other hand, 
	if you want to assess the total financial impact of salaries in each state, the total salary approach would be more appropriate.
Tocantins: Tocantins has the highest average salary among the analyzed states, with an average of $72,079. This indicates that compensation levels in Tocantins are the highest compared to the other states.
Goias: Goias follows with an average salary of $54,249, indicating competitive compensation levels that are lower than Tocantins but higher than DistritoFederal.
DistritoFederal: DistritoFederal has the lowest average salary among the analyzed states, with an average of $33,484. This suggests that compensation levels in DistritoFederal are the lowest compared to Goias and Tocantins.
These insights provide an understanding of how average salary levels vary across different states, which can be valuable for talent management, recruitment strategies, and regional operations planning
*/

## 4.How standardized is our pay policy across the states?
--with respective to financial impact of salaries on each state 
select company_state,
		cast(sum(salary) as int) total_salary
from df_employee
group by company_state
order by total_salary
/* company_state	total_salary
Tocantins	20902959
DistritoFederal	88333112
Goias	245911513 */
/*insights:
Insights for Management:
Disparity in Total Salary Expenditure: 
	There is significant variation in total salary expenditure across states. Goias has the highest total salary expenditure, followed by DistritoFederal and Tocantins. This suggests that a large portion of the organization's financial resources is allocated to employees in Goias, indicating potentially higher compensation levels or a larger workforce in that region.
Regional Compensation Analysis: 
	The data highlights regional differences in compensation allocation. Management should assess the factors contributing to these disparities, such as market dynamics, cost of living, or workforce demographics, to ensure fair and consistent compensation practices across all regions.
Policy Alignment: 
	Management should evaluate whether the organization's pay policy aligns with its strategic objectives and values. Discrepancies in total salary expenditure may indicate areas where the pay policy needs adjustment to ensure equitable treatment of employees across states.
Resource Allocation Considerations: 
	The significant difference in total salary expenditure across states may impact resource allocation decisions. Management should consider these disparities when allocating budget resources, staffing decisions, and strategic investments to optimize operational efficiency and effectiveness.
Benchmarking and Review: 
	The data provides an opportunity for benchmarking and review of compensation practices. Management should compare total salary expenditure across states with industry benchmarks and internal performance metrics to identify areas for improvement and ensure competitive compensation packages that attract and retain top talent.
By considering these insights, management can make informed decisions to optimize compensation management practices, promote fairness and equity in pay policy implementation, and align resource allocation strategies with organizational goals and objectives.

## 5.How experienced is our engineering team?
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

## 6. In what function groups do we spend the most?
  */
select function_group,SUM(salary) as total_salary 
from df_employee 
group by function_group
order by total_salary desc
/*o/p:
function_group	total_salary
Professionals	155927107
Assistants	64964829
Administration	40446195
Production Supervisors	40417245
Engineering	21208651
Machine Operators	16119104
Managers	15940003
Trainees	124450
*/

/*insights:
Salary Distribution Across Function Groups: The highest total salary is allocated to the "Professionals" function group, indicating that this group likely consists of roles with higher pay grades or specialized skills compared to other groups.
Resource Allocation: The significant salary expenditure on "Assistants" and "Administration" suggests that these functions play crucial roles within the organization, likely supporting various operational activities.
Management and Supervisory Roles: "Production Supervisors" and "Managers" also command substantial salary expenditures, highlighting the importance of leadership and oversight within the organization.
Investment in Engineering: While not the highest, the allocation to the "Engineering" function group is noteworthy, indicating the organization's investment in technical expertise and innovation.
Training Initiatives: The relatively lower salary expenditure on "Trainees" may indicate a focus on developing talent within the organization, with lower initial compensation as trainees gain experience and skills.
These insights can inform decision-making processes related to budget allocation, resource planning, talent management, and organizational strategy.
*/

## 7. What construction sites spent the most in salaries for the period?
*/
-- query will provide the total salary expenditure for each construction site category, allowing you to identify which construction sites spent the most in salaries for the given period.
select const_site_category, sum(salary) sum_Salary
from df_employee
group by const_site_category
order by sum_salary desc
/* output:
const_site_category	sum_Salary
Construction Site	299514752
Administration	55079895
Development Center	513014
Construction Sites	39923 */

/* insight:
Dominant Salary Expenditure: 
	The "Construction Site" category commands the highest total salary expenditure, indicating that a significant portion of resources is allocated to personnel working directly on construction sites. This suggests that managing and optimizing labor costs on construction projects should be a priority.
Supporting Functions: 
	The "Administration" category also incurs substantial salary expenses, highlighting the importance of administrative roles in supporting construction operations. Management may want to ensure that these functions are efficient and aligned with project needs.
Development Center: 
	Although relatively small compared to the construction site-related expenditures, the salary expenditure for the "Development Center" category suggests investment in research, innovation, or specialized activities. Management could assess the effectiveness of these investments in driving project success or organizational growth.
Minor Expenditure on Other Categories: 
	The salary expenditures for "Construction Sites" and other categories are significantly lower compared to the main categories. While these may represent minor operational costs, management should still monitor and optimize spending in these areas to ensure cost-effectiveness across all aspects of the business.
Overall, these insights can inform decision-making regarding resource allocation, cost management strategies, and optimizing operational efficiency in construction-related activities.
