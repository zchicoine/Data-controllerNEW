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

    describe 'Save a unsuccessful email' do
        it 'should be save to the recovery database, see this file for more database configuration lib/Data_Controller/db/recovery/aws_secrets.yml' do
            email = {status:'fail',body:'email body', subject:'email subject', email_address:'email address2',date:Time.now.to_s,from:'brokers@noemail.com'}
            expect(@dataController.unsuccessful_email(email)).to eq  email
        end

    end

    describe 'retrieve all a unsuccessful email' do
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
end