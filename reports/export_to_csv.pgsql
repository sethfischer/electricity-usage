/**
 * Export data to CSV files.
 */

/*
 * Export table readings to CSV file grouped by year.
 */

-- plain output without headers
\a
\t

-- spool output into a file
\o output/export.tmp.sql

SELECT
    format(
        '\copy ('
            || 'SELECT icp_number, meter_serial_number, channel_number, started_at, ended_at, value, unit_code, status '
            || 'FROM readings WHERE EXTRACT(YEAR FROM started_at) = %L ORDER BY started_at) '
            || 'to ''output/%s.csv'' CSV HEADER',
        _year,
        _year
    )
FROM
    (
        SELECT
            DISTINCT EXTRACT(YEAR FROM started_at) AS _year
        FROM
            readings
        ORDER BY _year
    ) _years
;

-- turn spooling off
\o

-- run generated file
\i output/export.tmp.sql


/*
 * Export table events to CSV file.
 */
\copy (SELECT started_at, ended_at, label, description FROM events ORDER BY started_at, ended_at) TO output/events.csv CSV HEADER


/*
 * Export table transactions to CSV file.
 */
\copy (SELECT transaction_at, amount, other_party, description, reference, particulars, analysis_code FROM transactions ORDER BY transaction_at, amount) TO output/transactions.csv CSV HEADER
