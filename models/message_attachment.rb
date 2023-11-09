# frozen_string_literal: true

require 'securerandom'

# message attachment model
class MessageAttachment
  attr_accessor :id, :message_id, :file_data, :file_name, :file_type, :created_at

  def initialize
    @id = SecureRandom.uuid
    @message_id = ''
    @file_data = nil
    @file_name = ''
    @file_type = ''
    @created_at = nil
  end
end
