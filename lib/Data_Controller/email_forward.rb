###
# This module is responsible for save data to either user database or recovery database
###
require_relative 'db/mainDB/DAL/broker'
require_relative 'db/mainDB/DAL/ship'
require_relative 'db/mainDB/DAL/port'
require_relative 'db/mainDB/DAL/shipment'
require_relative 'db/mainDB/mainDB_config'
require_relative 'db/recoveryDB/DAL/email'
module DataController
    module EmailForward

        # TODO see issue #1
        # :description save data passing to user database
        # :param [Hash] {email:{status:'succ',body:,subject:,from:,etc}, ship_info:[{ship_name:,port_name:,open_date:},etc]}
        # :raise [ArgumentError,NoMethodError,ActiveRecord::RecordNotFound,ActiveRecord::RecordInvalid, etc]
        # :return if successful [param] data is returned
        def successful_email(data)
            raise ArgumentError.new('emails status has to equal to succ') if data[:email][:status] != 'succ'
            connect_to_mainDb
            broker = DataController::DB::MainDB::DAL::Broker.find_by!(email:data[:email][:from])
            ship = DataController::DB::MainDB::DAL::Ship.find_by!(name:data[:ship_info][:ship_name])
            port = DataController::DB::MainDB::DAL::Port.find_by!(name:data[:ship_info][:port_name])
            shipment = DataController::DB::MainDB::DAL::Shipment.new
            shipment.ship = ship
            shipment.port = port
            shipment.open_start_date = data[:ship_info][:open_date]
            shipment.brokers.push(broker)
            shipment.save!
            data
        end

        # :description save data passing to the recovery database.
        # saving an already saved email would result to update the old value.
        # Subject, body and email address of an email is used to generate a unique ID for the email.
        # :param [Hash] {status:'fail',body:,subject:,from:,email_address, date:,etc}
        # :raise [ArgumentError,NoMethodError,ActiveRecord::RecordNotFound,ActiveRecord::RecordInvalid, etc]
        # :return if successful [param] data is returned
        def unsuccessful_email(data)
            raise ArgumentError.new('emails status has to equal to fail') if data[:status] != 'fail'
            recovery_db = DataController::DB::RecoveryDB::DAL::Email.new(data)
            recovery_db.save
            data
        end

        private
        # :description TODO investigate whether this function can be move some where.
        def connect_to_mainDb
            DataController::DB::MainDB::Config.connect
        end
    end
end