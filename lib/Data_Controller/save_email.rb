###
# This module is responsible for save data to either user database or recovery database
###
module DataController
    module SaveEmail

        # :description save data passing to user database
        # :param [Hash] {email:{status:'succ',body:,subject:,original_sender:,email_address, date:, etc}, ship_info:[{ship_name:,port_name:,open_date:},etc]}
        # :raise [ArgumentError,NoMethodError,ActiveRecord::RecordNotFound,ActiveRecord::RecordInvalid, etc]
        # :return if successful [param] data is returned
        def successful_email(data)
            raise ArgumentError.new('emails status has to equal to succ') if data[:email][:status] != 'succ'
            broker = DataController::DB::MainDB::DAL::Broker.find_by!(email:data[:email][:email_address])
            email = DataController::DB::MainDB::DAL::ShipEmail.new
            email.email_body = data[:email][:body]
            email.email_subject = data[:email][:subject]
            email.email_date = Date.parse(data[:email][:date])
            email.original_email_address = data[:email][:original_sender]
            email.broker = broker
            data[:ship_info].each do |item|
                shipment = DataController::DB::MainDB::DAL::Shipment.new
                shipment.ship = DataController::DB::MainDB::DAL::Ship.find_by!(:name => item[:ship_name])
                shipment.port = DataController::DB::MainDB::DAL::Port.find_by!(:name => item[:port_name])
                shipment.open_start_date = item[:open_date]
                # associate shipments to an email and a broker
                email.shipments.push(shipment)
                broker.shipments.push(shipment)
            end
            broker.save!
            email.save!
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
    module SaveBrokerStatus

        # :description take information about the a broker email status
        # :param [Hash] {broker_email_address:,ship:0,personal:0,order:0,not_ship:0}
        # :param [Boolean] if is true broker data will be replace, otherwise increment.
        #   For example: if a broker has 20 order email, it will be 20 + data[:order] if update == false
        # :return [Hash] if successful new value is returned {broker_email_address:,ship:,personal:,order:,not_ship:}
        def email_status(data,update = false)
            broker = DataController::DB::MainDB::DAL::Broker.find_by!(email:data[:broker_email_address])
            if update
                broker.num_ship_emails = data[:ship]
                broker.num_personal_emails = data[:personal]
                broker.num_order_emails = data[:order]
                broker.num_not_ship_emails = data[:not_ship]
                broker.save
            else
                broker.num_ship_emails = broker.num_ship_emails + data[:ship]
                broker.num_personal_emails = broker.num_personal_emails + data[:personal]
                broker.num_order_emails = broker.num_order_emails + data[:order]
                broker.num_not_ship_emails =  broker.num_not_ship_emails + data[:not_ship]
                broker.save
            end
            return {broker_email_address:broker.email,
                    ship:broker.num_ship_emails,
                    personal:broker.num_personal_emails ,
                    order:broker.num_order_emails,
                    not_ship:broker.num_not_ship_emails
            }
        end
    end
end