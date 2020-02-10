/**
 * Consumption by month.
 */
SELECT
    TO_CHAR(started_at, 'YYYY-MM') AS year_month,
    SUM(value) AS monthly_usage
FROM
    readings
GROUP BY
    year_month
ORDER BY
    year_month
;
