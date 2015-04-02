require 'Data_Controller/version'
require_relative 'Data_Controller/email_forward'
module DataController
    extend DataController::EmailForward
    # p successful_email({email:{status:'succ',from:'brokers@noemail.com'},ship_info:{ship_name:'hidalga',port_name:'aarhus', open_date:Time.now.to_s}})
end