CREATE TABLE notifications
(
  id         SERIAL PRIMARY KEY,
  type       notification_type NOT NULL,
  message    TEXT              NOT NULL,
  created_at TIMESTAMP         NOT NULL DEFAULT CURRENT_TIMESTAMP,
  profile_id INTEGER,
  FOREIGN KEY (profile_id) REFERENCES profile (id) ON DELETE SET NULL
);
