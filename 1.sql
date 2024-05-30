--1. Has the average salary decreased or increased since January 2022?
select  year(month_year) years,
		month(month_year) months,
		cast(AVG(salary)as int) avg_salary 
from df_employee
group by year(month_year),month(month_year)
order by year(month_year),month(month_year)

/* o/p:
years	months	avg_salary
2022	1	21836
2022	2	23943
2022	3	30100
2022	4	31985
2022	5	43574
2022	6	48388
2022	7	52068
2022	8	55075
2022	9	54341
2022	10	60374
2022	11	56956
2022	12	57887
2023	1	69391  */

/* insights:
	the average salary has increased since January 2022.
add info:
The average salary shows an increasing trend from January 2022 to January 2023.
In January 2022, the average salary was 21,836 units, and it steadily increased over the months, reaching 69,391 units in January 2023.
This suggests that the average salary has increased over the specified period, indicating potential growth or changes in compensation practices within the organization.
In summary, based on the query output, the average salary has increased since January 2022.
*/