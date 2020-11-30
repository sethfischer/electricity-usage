/*
 * `readings` table.
 */

DROP TABLE IF EXISTS readings;
DROP TYPE IF EXISTS unit;
DROP TYPE IF EXISTS status;

CREATE TYPE reading_unit AS ENUM ('kWh');
CREATE TYPE reading_status AS ENUM (
    'different missing scaled estimated',
    'different scaled estimated',
    'different scaled',
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


/*
 * `events` table.
 */

DROP TABLE IF EXISTS events;

CREATE TABLE events(
    id SERIAL PRIMARY KEY,
    started_at TIMESTAMP NOT NULL,
    ended_at TIMESTAMP NULL DEFAULT NULL,
    label VARCHAR(15) NOT NULL,
    description VARCHAR(255) NOT NULL
);

COMMENT ON COLUMN events.started_at IS 'Event start time.';
COMMENT ON COLUMN events.ended_at IS 'Event end time.';
COMMENT ON COLUMN events.label IS 'Short label describing event.';
COMMENT ON COLUMN events.description IS 'Long description of event.';

CREATE INDEX events_started_at ON events(started_at);
CREATE INDEX events_ended_at ON events(ended_at);
CREATE UNIQUE INDEX events_label ON events(label);


/*
 * `transactions` table.
 */

DROP TABLE IF EXISTS transactions;
DROP TYPE IF EXISTS transaction_description;

CREATE TYPE transaction_description AS ENUM (
    'DC',
    'DD'
);

CREATE TABLE transactions(
    id SERIAL PRIMARY KEY,
    transaction_at TIMESTAMP NOT NULL,
    amount MONEY NOT NULL,
    other_party VARCHAR(20) NOT NULL,
    description transaction_description NOT NULL,
    reference VARCHAR(12) NULL,
    particulars VARCHAR(12) NOT NULL,
    analysis_code VARCHAR(12) NULL
);

COMMENT ON COLUMN transactions.transaction_at IS 'Transaction time.';
COMMENT ON COLUMN transactions.amount IS 'Transaction amount.';

CREATE INDEX transactions_transaction_at ON transactions(transaction_at);
CREATE INDEX transactions_amount ON transactions(amount);
