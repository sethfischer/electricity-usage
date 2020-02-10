DROP TABLE IF EXISTS flick_legacy_readings;
DROP TYPE IF EXISTS flick_legacy_meter_configuration;

CREATE TYPE flick_legacy_meter_configuration AS ENUM ('IN');

CREATE TABLE flick_legacy_readings(
    id SERIAL PRIMARY KEY,
    icp_number VARCHAR(15) NOT NULL,
    meter_serial_number VARCHAR(12) NOT NULL,
    meter_configuration flick_legacy_meter_configuration NOT NULL,
    date_of_consumption DATE NOT NULL,
    half_hour_trading_period SMALLINT NOT NULL,
    trading_period_time TIME NOT NULL,
    interval_consumption NUMERIC(5, 3) NOT NULL
);

COMMENT ON COLUMN flick_legacy_readings.icp_number IS 'Installation Control Point number.';
COMMENT ON COLUMN flick_legacy_readings.meter_serial_number IS 'Meter serial number.';
COMMENT ON COLUMN flick_legacy_readings.meter_configuration IS 'Meter configuration.';
COMMENT ON COLUMN flick_legacy_readings.date_of_consumption IS 'Date of reading.';
COMMENT ON COLUMN flick_legacy_readings.half_hour_trading_period IS 'Index of half-hour trading period. An integer between 1 and 48.';
COMMENT ON COLUMN flick_legacy_readings.trading_period_time IS 'Time of day start of half-hour trading period.';
COMMENT ON COLUMN flick_legacy_readings.interval_consumption IS 'Energy used during trading period.';

CREATE INDEX date_of_consumption ON flick_legacy_readings(date_of_consumption);
CREATE INDEX half_hour_trading_period ON flick_legacy_readings(half_hour_trading_period);
CREATE INDEX trading_period_time ON flick_legacy_readings(trading_period_time);
