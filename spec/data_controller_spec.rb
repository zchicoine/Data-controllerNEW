require_relative 'spec_helper'

RSpec.describe DataController do

    before :all do
        DataController::DB::MainDB::Config.connect
    end
    before :each do
        @dataController = DataController.new
    end

    describe 'Save a successful email' do
        it 'should be save to the development database, see this file for more database configuration lib/Data_Controller/db/mainDB/database.yml' do
            email = {email:{status:'succ',from:'brokers@noemail.com'},ship_info:{ship_name:'hidalga',port_name:'aarhus', open_date:Time.now.to_s}}
            expect(@dataController.successful_email(email)).to eq  email
        end

    end

    describe 'Save an unsuccessful email' do
        it 'should be save to the recovery database, see this file for more database configuration lib/Data_Controller/db/recovery/aws_secrets.yml' do
            email = {status:'fail',body:'email body ...', subject:'email subject ...', email_address:'email_address@example.com',date:Time.now.to_s,from:'brokers@noemail.com'}
            expect(@dataController.unsuccessful_email(email)).to eq  email
        end

    end

    describe 'retrieve all unsuccessful email' do
        it 'should be return all unsuccessful emails that have been saved to the recovery database, see this file for more database configuration lib/Data_Controller/db/recovery/aws_secrets.yml' do
            email =
            expect(@dataController.retrieve_unsuccessful_emails).not_to be_empty
        end

    end
    describe 'Save a successful email' do
        it 'should be save to the development database, see this file for more database configuration lib/Data_Controller/db/mainDB/database.yml' do
            email = {status:'fail',body:'email body', subject:'email subject', email_address:'email address2',date:Time.now.to_s,from:'brokers@noemail.com'}
            @dataController.unsuccessful_email(email)
            email_address = email[:email_address]
            expect(@dataController.retrieve_unsuccessful_emails_by_email_address(email_address)).not_to be_empty
        end
    end
    describe 'delete and archive an unsuccessful email' do
        it 'should be saved and then deleted from the recovery database, see this file for more database configuration lib/Data_Controller/db/recovery/aws_secrets.yml' do
            email = {status:'fail',body:'email body testing', subject:'email subject testing', email_address:'1029384756_email_ad@testing.com',date:Time.now.to_s,from:'brokers@testing.com'}
            expect(@dataController.unsuccessful_email(email)).to eq  email
            retrieved_email = @dataController.retrieve_unsuccessful_emails_by_email_address(email[:email_address])[0]
            @dataController.delete_unsuccessful_emails(retrieved_email['Key'],email[:email_address])
            expect(@dataController.retrieve_unsuccessful_emails_by_email_address(email[:email_address])).to be_nil
        end
        it 'should be saved and then archive from the recovery database, see this file for more database configuration lib/Data_Controller/db/recovery/aws_secrets.yml' do
            email = {status:'fail',body:'email body testing2', subject:'email subject testing2', email_address:'1029384756_email_ad2@testing.com',date:Time.now.to_s,from:'brokers2@testing.com'}
            expect(@dataController.unsuccessful_email(email)).to eq  email
            retrieved_email = @dataController.retrieve_unsuccessful_emails_by_email_address(email[:email_address])[0]
            @dataController.archive_unsuccessful_emails(retrieved_email['Key'],email[:email_address])
            expect(@dataController.retrieve_unsuccessful_emails_by_email_address(email[:email_address])[0]['archive']).to be true
            @dataController.delete_unsuccessful_emails(retrieved_email['Key'],email[:email_address])
        end
    end
end