select * from df_employee

--2.How effective is our HR program to reduce the gender gap?
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