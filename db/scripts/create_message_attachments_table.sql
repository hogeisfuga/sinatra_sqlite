CREATE TABLE IF NOT EXISTS message_attachments (
  id          UUID PRIMARY KEY,
  message_id  UUID,
  file_data   BLOB,
  file_name   VARCHAR,
  file_type   VARCHAR,
  created_at  DATE,
  FOREIGN KEY (message_id) REFERENCES messages(id)
);