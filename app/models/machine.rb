class Machine
  include Mongoid::Document

  attr_accessor :old_description

  field :dns_name,    type: String
  field :ip_address,  type: String
  field :description, type: String

  after_update :sync_associated_data

  # this will update the associated fields
  def sync_associated_data
    change = WebAppInstance.where(machine_desc: old_description)
    change.map {|x| x.machine_desc = description; x.save }
  end

end