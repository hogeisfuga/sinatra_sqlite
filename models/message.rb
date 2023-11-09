# frozen_string_literal: true

require 'securerandom'

# message model
class Message
  attr_accessor :id, :name, :content, :created_at

  def initialize
    @id = SecureRandom.uuid
    @name = ''
    @content = ''
    @created_at = nil
  end
end
