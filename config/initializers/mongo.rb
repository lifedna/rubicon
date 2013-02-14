Mongoid.load!("config/mongoid.yml")

# MongoMapper.connection = Mongo::Connection.new('165.219.88.72', 27017)

# # this is needed to setup test / dev / prod dbs
# MongoMapper.database = "#rubicon-#{Rails.env}"

# if defined?(PhusionPassenger)
#    PhusionPassenger.on_event(:starting_worker_process) do |forked|
#      MongoMapper.connection.connect if forked
#    end
# end
