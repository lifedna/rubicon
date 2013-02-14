class GitProject
  include Mongoid::Document

  field :project,     type: String
  field :description, type: String
  field :last_change, type: String

end