# frozen_string_literal: true

require 'sqlite3'
require 'base64'

# repository messages
class MessageAttachmentRepository
  class << self
    # rubocop:disable Metrics/MethodLength
    def insert(msg_attachments)
      msg_attachments.each do |attachment|
        db.execute(
          "INSERT INTO message_attachments (id, message_id, file_data, file_name, file_type, created_at)
          VALUES (?, ?, ?, ?, ?, ?)",
          attachment.id,
          attachment.message_id,
          SQLite3::Blob.new(attachment.file_data),
          attachment.file_name,
          attachment.file_type,
          Time.now.strftime('%Y-%m-%d %H:%M:%S')
        )
      end
    end
    # rubocop:enable Metrics/MethodLength

    def find_all_by_message_id(id)
      attachments = db.execute <<-SQL
        select * from message_attachments where message_id = '#{id}';
      SQL

      (attachments || []).map do |attachment|
        id, message_id, file_data, file_name, file_type, created_at = attachment
        file_data = if file_type.match?(%r{text/plain})
                      file_data.force_encoding('UTF-8').encode('UTF-8')
                    else
                      Base64.encode64(file_data)
                    end
        MessageAttachment.new(id:, message_id:, file_data:, file_name:, file_type:, created_at:)
      end
    end

    private

    def db
      @db ||= SQLite3::Database.open './db/sample_db.sqlite3'
    end
  end
end
