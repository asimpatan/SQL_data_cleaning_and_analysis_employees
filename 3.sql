--3:How are our salaries distributed across the states?

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