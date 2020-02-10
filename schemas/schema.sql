/*
 * `readings` table.
 */

DROP TABLE IF EXISTS readings;
DROP TYPE IF EXISTS unit;
DROP TYPE IF EXISTS status;

CREATE TYPE reading_unit AS ENUM ('kWh');
CREATE TYPE reading_status AS ENUM (
    'different missing scaled estimated',
    'different',
    'validated'
);

CREATE TABLE readings(
    id SERIAL PRIMARY KEY,
    icp_number VARCHAR(15) NOT NULL,
    meter_serial_number VARCHAR(10) NOT NULL,
    channel_number SMALLINT NOT NULL,
    started_at TIMESTAMP NOT NULL,
    ended_at TIMESTAMP NOT NULL,
    value NUMERIC(5, 3) NOT NULL,
    unit_code reading_unit NOT NULL,
    status reading_status NULL DEFAULT NULL
);

COMMENT ON COLUMN readings.icp_number IS 'Installation Control Point number.';
COMMENT ON COLUMN readings.meter_serial_number IS 'Meter serial number.';
COMMENT ON COLUMN readings.channel_number IS 'Channel number.';
COMMENT ON COLUMN readings.started_at IS 'Start of half-hour trading period.';
COMMENT ON COLUMN readings.ended_at IS 'End of half-hour trading period.';
COMMENT ON COLUMN readings.value IS 'Energy used during trading period.';
COMMENT ON COLUMN readings.unit_code IS 'Reading unit.';
COMMENT ON COLUMN readings.status IS 'Reading status.';

CREATE INDEX readings_started_at ON readings(started_at);
CREATE INDEX readings_ended_at ON readings(ended_at);
CREATE INDEX readings_value ON readings(value);

/*
 * Cannot create these indexes due to daylight savings time adjustments.
 *
 * $ grep -n "07/04/2019 02:00" data/0000121203TREF2/usage/original/2019_flick.csv
 * 4614:0000121203TREF2,U999999999,1,07/04/2019 02:00,07/04/2019 02:29,0.104,kWh,validated
 * 4616:0000121203TREF2,U999999999,1,07/04/2019 02:00,07/04/2019 02:29,0.196,kWh,validated
 * $ grep -n "07/04/2019 02:30" data/0000082102TR1DA/usage/original/2019_flick.csv
 * 4615:0000121203TREF2,U999999999,1,07/04/2019 02:30,07/04/2019 02:59,0.323,kWh,validated
 * 4617:0000121203TREF2,U999999999,1,07/04/2019 02:30,07/04/2019 02:59,0.457,kWh,validated
 */
-- CREATE UNIQUE INDEX unique_started_at ON readings(started_at);
-- CREATE UNIQUE INDEX unique_ended_at ON readings(ended_at);
-- CREATE UNIQUE INDEX started_at_ended_at_unique ON readings(started_at, ended_at);
