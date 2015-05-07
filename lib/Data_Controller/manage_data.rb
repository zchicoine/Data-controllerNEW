###
# This module is responsible for retrieving data from either website data base or recovery database
###
module DataController
    module RetrieveData

        # :description getting all the emails that have not been successfully recognized
        # :return [Hash] {TODO hash format}
        def retrieve_unsuccessful_emails
            _emails = DataController::DB::RecoveryDB::DAL::Email.find_all
            return _emails unless _emails.blank?
        end

        # :description getting all the emails that have not been successfully recognized
        # :params [String] email address
        # :return [Hash] {TODO hash format}
        def retrieve_unsuccessful_emails_by_email_address(email_address)
            _emails = DataController::DB::RecoveryDB::DAL::Email.find_all_by_email_address(email_address)
            return _emails unless _emails.blank?
        end
    end

    module DeleteData
        # :description delete an email
        # :param [String] key of the email
        # :param [String] email address
        # :raise [Aws::DynamoDB::Errors::ValidationException] if no key and email match
        def delete_unsuccessful_emails(key, email_address)
            DataController::DB::RecoveryDB::DAL::Email.delete(key,email_address)
        end
        # :description archive an email
        # :param [String] key of the email
        # :param [String] email address
        # :raise [Aws::DynamoDB::Errors::ValidationException] if no key and email match
        def archive_unsuccessful_emails(key, email_address)
            DataController::DB::RecoveryDB::DAL::Email.delete(key,email_address,true)
        end
    end
end