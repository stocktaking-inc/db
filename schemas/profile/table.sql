CREATE TABLE profile
(
    id               SERIAL PRIMARY KEY,
    name             VARCHAR(100) NOT NULL,
    email            VARCHAR(100) NOT NULL,
    phone            VARCHAR(20),
    company          VARCHAR(100),
    position         VARCHAR(100),
    description      TEXT,
    password_hash    TEXT         NOT NULL,
    settings_id      INTEGER UNIQUE,
    business_plan_id INTEGER,
    FOREIGN KEY (settings_id) REFERENCES settings (id) ON DELETE SET NULL,
    FOREIGN KEY (business_plan_id) REFERENCES business_plans (id) ON DELETE SET NULL
);
