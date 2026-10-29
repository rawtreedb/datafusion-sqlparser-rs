SELECT query_type, query FROM query_log ORDER BY event_time DESC LIMIT 1 BY query_type, query LIMIT 1000 SETTINGS max_execution_time = 15;
SELECT * FROM t LIMIT 1, 2 BY a LIMIT 3, 10;
