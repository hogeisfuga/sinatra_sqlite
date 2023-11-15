# frozen_string_literal: true

require 'securerandom'

# message model
class Message
  attr_accessor :id, :name, :content, :created_at, :attachments

  def initialize(name:, content:, id: nil, created_at: nil)
    @id = id || SecureRandom.uuid
    @name = name || ''
    @content = content || ''
    @created_at = created_at || nil
    @attachments = []
  end
end
