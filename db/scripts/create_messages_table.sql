CREATE TABLE IF NOT EXISTS messages (
  id          UUID PRIMARY KEY,
  name        VARCHAR,
  content     TEXT,
  created_at  DATE
);
