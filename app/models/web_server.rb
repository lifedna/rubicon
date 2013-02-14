class WebServer
  include Mongoid::Document

  field :description, type: String
  field :short_name,  type: String

end