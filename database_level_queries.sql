SELECT
    r.session_id,
    s.login_name,
    r.start_time,
    r.status,
    r.command,
    r.database_id,
    r.total_elapsed_time,
    r.wait_type,
    r.wait_time,
    r.wait_resource,
    SUBSTRING(st.text, (r.statement_start_offset/2)+1,
           ((CASE r.statement_end_offset
             WHEN -1 THEN DATALENGTH(st.text)
             ELSE r.statement_end_offset
             END - r.statement_start_offset)/2) + 1) AS statement_text
FROM
    sys.dm_exec_requests r
JOIN
    sys.dm_exec_sessions s ON r.session_id = s.session_id
CROSS APPLY
    sys.dm_exec_sql_text(r.sql_handle) st
WHERE
    r.status IN ('running', 'suspended') -- Include only running or suspended queries
    AND r.total_elapsed_time > 60 -- Identify queries running for more than 60 seconds
ORDER BY
    r.total_elapsed_time DESC; -- Order by elapsed time to identify the longest-running queries first

SELECT name,database_id FROM sys.databases WHERE name = 'employee_salaries_project';
