require 'active_record'
require 'logger'

module MainDBConfig
    class << self

        # :description connect to database, to change configuration of database please see database.yml file
        def connect
            ActiveRecord::Base.logger = Logger.new('debug.log') # I don't why I need this
            configuration = YAML::load(IO.read('db/mainDB/database.yml'))
            ActiveRecord::Base.establish_connection(configuration['development'])
        end

    end
end
