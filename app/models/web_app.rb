class WebApp
  include Mongoid::Document

  include ActiveModel::Validations
  validates_with WebAppValidator

  attr_accessor :old_name

  field :git_name, type: String
  field :name,     type: String
  field :url,      type: String
  field :aka,      type: String
  field :note,     type: String

  after_update :sync_associated_data

  # this will update the associated fields
  def sync_associated_data
    change = WebAppInstance.where(name: old_name)
    change.map {|x| x.name = name; x.save }
  end

  def gitlab_link
    return git_name if git_name.blank?
    git_name.split(":").last.split(".").first
  end

  # create a comma separated list of each aka
  def aka_csv
    operations = lambda{|x| x.strip.titleize }
    aka.split(/(\r)?\n/).delete_if(&:blank?).map(&operations).join(', ')
  end

end
