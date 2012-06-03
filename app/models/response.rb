require "net/https"
require "uri"
require 'json'

class Response < ActiveRecord::Base
  belongs_to :user
  belongs_to :challenge

  validates :user_id, :presence => true
  validates :challenge_id, :presence => true

  after_initialize do |response|
    if response.new_record?
      response.attempts = 0
    end
  end

  def points_for_this_attempt
    if attempts <= 1
      10
    elsif attempts == 2
      5
    elsif attempts == 3
      2
    else
      1
    end
  end

  def make_giverboard_purchase(user)
    uri = URI.parse('https://www.giverboard.com/api/v1_1/record_purchase')
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE

    params = {
      :api_key => "ba4189f5dffe0e4142ed7e150862403396327b65",
      :campaign_id => 40,
      :virtual_object_id => 46,
      :player_email => user.email
    }

    request = Net::HTTP::Post.new(uri.request_uri)
    request.add_field('content-type', 'application/json')
    request.body = params.to_json

    response = http.request(request)
  end
end
