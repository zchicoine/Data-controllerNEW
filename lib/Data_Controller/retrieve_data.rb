###
# This module is responsible for retrieving data from either website data base or recovery database
###
require_relative 'db/recoveryDB/DAL/email'
module DataController
    module RetrieveData

        # :description getting all the emails that have not been successfully recognized
        # :return [Hash] {TODO hash format}
        def retrieve_unsuccessful_emails
            _emails = DataController::DB::RecoveryDB::DAL::Email.find_all
            return _emails[0] unless _emails.blank?
        end

        # :description getting all the emails that have not been successfully recognized
        # :params [String] email address
        # :return [Hash] {TODO hash format}
        def retrieve_unsuccessful_emails_by_email_address(email_address)
            _emails = DataController::DB::RecoveryDB::DAL::Email.find_all_by_email_address(email_address)
            return _emails[0] unless _emails.blank?
        end
    end
end