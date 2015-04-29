require 'active_record'
require 'logger'
module DataController
    module DB
        module MainDB
            module Config

                class << self
                    # :description connect to database, to change the default configuration of database please see database.yml file
                    # :param [option Hash] configuration  {'adapter':, 'pool':, 'timeout':, 'host':, 'database':, 'username':, 'password':}
                    # if it is not blanked then it will be used. Otherwise it will use database.yml file info
                    # :raise it may raise exception while establishing a connection
                    def connect(configuration = {})
                        ActiveRecord::Base.logger = Logger.new('debug.log') # TODO change the file name

                        if configuration.keys.blank?
                            _configuration = YAML::load(File.read('Data_Controller/db/mainDB/database.yml'))
                            ActiveRecord::Base.establish_connection(_configuration['development'])
                        else
                            ActiveRecord::Base.establish_connection(configuration)
                        end
                    end
                end # class self

            end # Config
        end # MainDB
    end # DB
end


