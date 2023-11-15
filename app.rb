# frozen_string_literal: true

require 'sinatra'
require 'debug'
require './models/message'
require './models/message_attachment'
require './repositories/message_repository'
require './repositories/message_attachment_repository'

get '/' do
  erb :index, layout: :layout
end

get '/messages' do
  messages = MessageRepository.all
  messages.each do |m|
    attachments = MessageAttachmentRepository.find_all_by_message_id(m.id)
    m.attachments = attachments || []
  end
  erb :messages, layout: :layout, locals: { messages: }
end

post '/messages' do
  msg = Message.new(name: params[:name], content: params[:content])
  if params[:file]
    file = params[:file]
    binary = file[:tempfile].read
    msg.attachments << MessageAttachment.new(message_id: msg.id, file_type: file[:type], file_name: file[:filename],
                                             file_data: binary)
  end

  # 本当はbegin transactionしないといけない
  # というよりリポジトリを２つ呼ぶこと自体が間違えている気がする
  MessageRepository.insert(msg)
  MessageAttachmentRepository.insert(msg.attachments) if msg.attachments.size.positive?

  messages = MessageRepository.all
  messages.each do |m|
    attachments = MessageAttachmentRepository.find_all_by_message_id(m.id)
    m.attachments = attachments || []
  end

  erb :messages, layout: :layout, locals: { messages: }
end

get '/messages_multipart' do
  messages = MessageRepository.all
  messages.each do |m|
    attachments = MessageAttachmentRepository.find_all_by_message_id(m.id)
    m.attachments = attachments || []
  end
  erb :messages, layout: :layout, locals: { messages: }
end

post '/messages_multipart' do
  parts = request.body.read.split(boundary[1])
  pp parts
  msg = Message.new(name: params[:name], content: params[:content])
  MessageRepository.insert(msg)
  messages = MessageRepository.all
  erb :messages_multipart, layout: :layout, locals: { messages: }
end
