###
#
###
require_relative 'db/mainDB/DAL/broker'
require_relative 'db/mainDB/DAL/ship'
require_relative 'db/mainDB/DAL/port'
require_relative 'db/mainDB/DAL/shipment'
require_relative 'db/mainDB/mainDB_config'
module DataController
    module EmailForward

        # TODO see issue #1
        # :param [Hash] {email:{status:'succ',body:,subject:,from:,etc}, ship_info:[{ship_name:,port_name:,open_date:},etc]}
        # :raise [ArgumentError,NoMethodError,ActiveRecord::RecordNotFound,ActiveRecord::RecordInvalid, etc]
        def successful_email(data)
            raise ArgumentError.new('emails status has to equal to succ') if data[:email][:status] != 'succ'
            connect_to_mainDb
            broker = DataController::DB::MainDB::Broker.find_by!(email:data[:email][:from])
            ship = DataController::DB::MainDB::Ship.find_by!(name:data[:ship_info][:ship_name])
            port = DataController::DB::MainDB::Port.find_by!(name:data[:ship_info][:port_name])
            shipment = DataController::DB::MainDB::Shipment.new
            shipment.ship = ship
            shipment.port = port
            shipment.open_start_date = data[:ship_info][:open_date]
            shipment.brokers.push(broker)
            shipment.save!
            shipment
        end

        private
        # :description
        def connect_to_mainDb
            DataController::DB::MainDB::Config.connect
        end
    end
end