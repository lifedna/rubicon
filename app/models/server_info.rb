class ServerInfo
  include Mongoid::Document

  require 'net/https'
  require 'uri'

  field :name,       type: String
  field :ip_address, type: String
  field :port,       type: String
  field :dns,        type: String


  def ip_status
    uri = URI.parse("https://#{self.ip_address}:#{self.port}")
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true if uri.scheme == "https"
    http.start {
      http.request_get(uri.path) {|res|
        puts res.body
      }
    }
  end


end