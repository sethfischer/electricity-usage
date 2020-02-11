/**
 * Total peak consumption.
 *
 * Monday-Friday: 0700-1100 + 1700-2100
 */
SELECT
    SUM(value) AS usage_peak
FROM
    readings
WHERE
    (
        (EXTRACT(HOUR FROM started_at) >= 7 AND EXTRACT(HOUR FROM started_at) < 11) -- 0700-1100
        OR (EXTRACT(HOUR FROM started_at) >= 17 AND EXTRACT(HOUR FROM started_at) < 21) -- 1700-2100
    )
    AND extract(isodow from started_at) NOT IN (6, 7) -- not including Saturday or Sunday
    --AND DATE_PART('year', started_at) = DATE_PART('year', CURRENT_DATE - INTERVAL '1 year') -- previous calendar year
;


/**
 * Total off-peak consumption.
 *
 * Monday-Friday  : 1100-1700 + 2100-0700
 * Saturday-Sunday: 0000-2400 (off-peak all day)
 */
SELECT
    SUM(readings_off_peak.value) AS usage_off_peak
FROM (
    SELECT
        value,
        started_at
    FROM
        readings
    WHERE
        ((EXTRACT(HOUR FROM started_at) >= 11 AND EXTRACT(HOUR FROM started_at) < 17) -- 1100-1700
        OR (EXTRACT(HOUR FROM started_at) >= 21 OR EXTRACT(HOUR FROM started_at) < 7)) -- 2100-0700
        AND extract(isodow from started_at) NOT IN (6, 7) -- not including Saturday or Sunday
    UNION
    SELECT
        value,
        started_at
    FROM
        readings
    WHERE
        extract(isodow from started_at) IN (6, 7) -- include only Saturday and Sunday
) AS readings_off_peak
--WHERE DATE_PART('year', started_at) = DATE_PART('year', CURRENT_DATE - INTERVAL '1 year') -- previous calendar year
;
