require 'active_record'
require 'logger'
require_relative 'data_controller/version'
require_relative '../lib/Data_Controller/db/recoveryDB/DAL/email'
require_relative 'data_controller/email_forward'
require_relative 'data_controller/manage_data'

###
# ActiveRecord throw an exception when using require or require_relative
# The exception is "ActiveSupport::Concern::MultipleIncludedBlocks: Cannot define multiple 'included' blocks for a Concern"
# Include any code using ActiveRecord in this file
###
module DataController
    module DB
        module MainDB
            module DAL
                ### ======================== Broker ======================== ###
                class Broker < ActiveRecord::Base
                    #!! cannot create or modify exciting broker

                    validates_presence_of :username
                    # in order to get the shipments and emails that associate to the broker
                    has_and_belongs_to_many :shipments
                    has_many :ship_emails
                end
                ### ======================== Port ======================== ###
                class Port < ActiveRecord::Base
                    # cannot create or modify exciting port
                    def readonly?
                        true
                    end
                    has_many :shipments
                    has_many :ships, :through => :shipments, :dependent => :destroy
                end # Port
                ### ======================== Ship ======================== ###
                class Ship < ActiveRecord::Base
                    # cannot create or modify exciting Ship
                    def readonly?
                        true
                    end
                    has_many :shipments
                    has_many :ports, :through => :shipments, :dependent => :destroy
                end # Ship
                ### ======================== ShipDetail ======================== ###
                class ShipDetail < ActiveRecord::Base
                    # cannot create or modify exciting ShipDetail
                    def readonly?
                        true
                    end
                end # ShipDetail
                ### ======================== Shipment ======================== ###
                class Shipment < ActiveRecord::Base
                    # validation
                    validates :port, :presence => true
                    validates :ship, :presence => true
                    validates :open_start_date, :presence => true

                    # relationship
                    belongs_to :port
                    belongs_to :ship
                    has_and_belongs_to_many :brokers
                    has_and_belongs_to_many :ship_emails
                end
                ### ======================== ShipEmail ======================== ###
                class ShipEmail < ActiveRecord::Base
                    validates_presence_of :broker
                    validates_presence_of :email_body
                    validates_presence_of :email_date
                    validates_presence_of :email_subject
                    belongs_to :broker
                    has_and_belongs_to_many :shipments
                end

            end # DAL
            module Config
                class << self
                    # :description connect to database, to change the default configuration of database please see database.yml file
                    # :param platform: ruby, jruby, etc. for now only ruby and jruby supported
                    # :param [option Hash] configuration  {'adapter':, 'pool':, 'url':, timeout':, 'host':, 'database':, 'username':, 'password':}
                    # if it is not blanked then it will be used. Otherwise it will use database.yml file info
                    # :raise [ActiveRecord::AdapterNotSpecified] it may raise exception while establishing a connection
                    def connect(platform = :ruby,configuration = {})
                        raise ArgumentError.new('platform has to be specified') if platform.nil?
                        ActiveRecord::Base.logger = Logger.new('debug.log') # TODO change the file name
                        if configuration.keys.blank?
                            _configuration = YAML::load(File.read(File.expand_path('../Data_Controller/db/mainDB/database.yml', __FILE__)))
                            ActiveRecord::Base.establish_connection(_configuration['development'][platform.to_s])
                        else
                            ActiveRecord::Base.establish_connection(configuration)
                        end
                    end
                end # class self
            end # Config
        end
    end # DB
end

###
#
###
module DataController

    class << self
        def new
            # Creating a Ruby Class on the fly
            Class.new do
                include Singleton
                include DataController::EmailForward
                include DataController::RetrieveData
                include DataController::DeleteData
            end.instance
        end
    end # self
end