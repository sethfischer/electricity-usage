/**
 * Consumption by year.
 */
SELECT
    EXTRACT(year FROM started_at) AS "year",
    SUM(value) AS annual_usage
FROM
    readings
GROUP BY
    "year"
ORDER BY
    "year"
;
