class WebAppInstance
  include Mongoid::Document
  # these are from web_app
  field :git_name,   type: String
  field :name,       type: String
  field :url,        type: String
  field :aka,        type: String
  field :ssl,        type: Boolean
  field :maint_page, type: Boolean

  # these are Instance specific
  field :environment,     type: String
  field :server,          type: String
  field :downstream_port, type: String

  # these are Machine specific stuff
  field :machine_desc,    type: String
  field :ip_address,      type: String
  field :dns_name,        type: String

  # update web app normalized data
  before_validation do |web_app|
    wa = WebApp.where(name: name).first
    self.url      = wa.url      if wa && wa.url
    self.aka      = wa.aka      if wa && wa.aka
    self.git_name = wa.git_name if wa && wa.git_name
  end

  # update machine normalized data
  before_validation do |web_app|
    mch = Machine.where(description: machine_desc).first
    self.ip_address = mch.ip_address if mch && mch.ip_address
    self.dns_name   = mch.dns_name   if mch && mch.dns_name
  end

  def self.default
    all.asc(:dns_name,:environment,:name)
  end

  def fqn
    "#{dns_name}.wicourts.gov"
  end
end
