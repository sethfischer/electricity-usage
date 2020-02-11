/**
 * Consumption by month accross years.
 */

-- CREATE EXTENSION IF NOT EXISTS tablefunc;

SELECT
    *
FROM
    crosstab(
        $$SELECT
            DATE_PART('year', started_at) AS year,
            to_char(started_at, 'mon') AS month,
            sum(value) AS value
        FROM readings
        GROUP BY
            1,2,month
        ORDER BY
            1,2,month$$
        ,$$VALUES
            ('jan'::text), ('feb'), ('mar'), ('apr'), ('may'), ('jun'), ('jul'), ('aug'), ('sep'), ('oct'), ('nov'), ('dec')$$
    ) AS ct (
        year int,
        jan NUMERIC(4), feb NUMERIC(4), mar NUMERIC(4), apr NUMERIC(4), may NUMERIC(4), jun NUMERIC(4),
        jul NUMERIC(4), aug NUMERIC(4), sep NUMERIC(4), oct NUMERIC(4), nov NUMERIC(4), dec NUMERIC(4)
    )
;
