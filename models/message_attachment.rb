# frozen_string_literal: true

require 'securerandom'

# message attachment model
class MessageAttachment
  attr_accessor :id, :message_id, :file_data, :file_name, :file_type, :created_at

  def initialize(message_id:, file_data:, file_name:, file_type:, id: nil, created_at: nil)
    @id = id || SecureRandom.uuid
    @message_id = message_id || ''
    @file_data = file_data || nil
    @file_name = file_name || ''
    @file_type = file_type || ''
    @created_at = created_at || nil
  end
end
