# frozen_string_literal: true

require 'sinatra'

get '/' do
  erb :index, layout: :layout
end
