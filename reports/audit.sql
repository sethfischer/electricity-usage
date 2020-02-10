/**
 * Audit readings.
 */


/**
 * Count readings.
 */
SELECT
    COUNT(*) AS number_of_readings,
    COUNT(*) / 48 AS number_of_days,
    MIN(started_at) AS min_started_at,
    MAX(ended_at) AS max_ended_at,
    MAX(ended_at) - MIN(started_at) AS dT_days
FROM
    readings
;

/**
 * Count identical started_at times.
 */
SELECT
    COUNT(*),
    started_at
FROM
    readings
GROUP BY
    started_at
HAVING
    COUNT(*) > 1
;


/**
 * Count identical ended_at times.
 */
SELECT
    COUNT(*),
    ended_at
FROM
    readings
GROUP BY
    ended_at
HAVING
    COUNT(*) > 1
;


/**
 * Rows with identical started_at.
 */
SELECT
    *
FROM
    readings
WHERE
    started_at IN (
        SELECT *
        FROM (
            SELECT started_at
            FROM readings
            GROUP BY started_at
            HAVING COUNT(started_at) > 1
        ) AS duplicates
    )
;

/**
 * Rows with identical ended_at.
 */
SELECT
    *
FROM
    readings
WHERE
    ended_at IN (
        SELECT *
        FROM (
            SELECT ended_at
            FROM readings
            GROUP BY ended_at
            HAVING COUNT(ended_at) > 1
        ) AS duplicates
    )
;
