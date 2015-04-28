require 'Data_Controller/version'
require_relative 'Data_Controller/email_forward'
require_relative 'data_controller/retrieve_data'
module DataController
    extend DataController::EmailForward
    extend DataController::RetrieveData
     #p successful_email({email:{status:'succ',from:'brokers@noemail.com'},ship_info:{ship_name:'hidalga',port_name:'aarhus', open_date:Time.now.to_s}})
     #p unsuccessful_email({status:'fail',body:'email body', subject:'email subject', email_address:'email address2',date:Time.now.to_s,from:'brokers@noemail.com'})
     # retrieve_unsuccessful_emails.each do |item|
     #    p item
     # end
     # p retrieve_unsuccessful_emails_by_email_address('email address')
end