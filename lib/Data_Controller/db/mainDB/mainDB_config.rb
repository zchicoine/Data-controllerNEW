require 'active_record'
require 'logger'
module DataController
    module DB
        module MainDB
            module Config

                class << self
                    # :description connect to database, to change configuration of database please see database.yml file
                    def connect
                        ActiveRecord::Base.logger = Logger.new('debug.log') # I don't why I need this
                        configuration = YAML::load(File.read('Data_Controller/db/mainDB/database.yml'))
                        ActiveRecord::Base.establish_connection(configuration['development'])
                    end
                end # class self

            end # Config
        end # MainDB
    end # DB
end


