# frozen_string_literal: true

require 'sqlite3'

# repository messages
class MessageRepository
  class << self
    def find(uuid)
      db.execute <<-SQL
        select * from messages where id = '#{uuid}';
      SQL
    end

    def insert(message)
      db.execute <<~SQL
        INSERT INTO messages (id, name, content, created_at)
        VALUES ('#{message.id}', '#{message.name}', '#{message.content}', '#{Time.now.strftime('%Y-%m-%d %H:%M:%S')}')
      SQL
    end

    def all
      messages = db.execute <<-SQL
        select * from messages;
      SQL

      messages.map do |msg|
        id, name, content, created_at = msg
        Message.new(id:, name:, content:, created_at:)
      end
    end

    private

    def db
      @db ||= SQLite3::Database.open './db/sample_db.sqlite3'
    end
  end
end
