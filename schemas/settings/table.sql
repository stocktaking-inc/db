CREATE TABLE settings
(
  id          SERIAL PRIMARY KEY,
  settings_id  INT NOT NULL,
  language    language_type    NOT NULL,
  time_zone   time_zone_type   NOT NULL,
  data_format data_format_type NOT NULL,
  currency    currency_type    NOT NULL
);
