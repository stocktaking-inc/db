CREATE TABLE business_plans
(
    id          SERIAL PRIMARY KEY,
    title       plan_type NOT NULL,
    description TEXT,
    price       INT       NOT NULL CHECK (price >= 0)
);
