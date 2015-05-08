###
# This module is responsible for save data to either user database or recovery database
###
module DataController
    module EmailForward

        # TODO see issue #1
        # :description save data passing to user database
        # :param [Hash] {email:{status:'succ',body:,subject:,from:,email_address,etc}, ship_info:[{ship_name:,port_name:,open_date:},etc]}
        # :raise [ArgumentError,NoMethodError,ActiveRecord::RecordNotFound,ActiveRecord::RecordInvalid, etc]
        # :return if successful [param] data is returned
        def successful_email(data)
            raise ArgumentError.new('emails status has to equal to succ') if data[:email][:status] != 'succ'
            broker = DataController::DB::MainDB::DAL::Broker.find_by!(email:data[:email][:email_address])
            data[:ship_info].each do |item|
                shipment = DataController::DB::MainDB::DAL::Shipment.joins(:port, :ship).new
                shipment.ship = DataController::DB::MainDB::DAL::Ship.joins(:ports).where('ports.name' => item[:port_name],'ships.name' => item[:ship_name])[0]
                shipment.port = shipment.ship.ports[0]
                shipment.open_start_date = item[:open_date]
                broker.shipments.push(shipment)
            end
            broker.save!
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
    end
end