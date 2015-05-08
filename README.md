# Data_Controller

Data Controller is responsible for  accessing databases for write and read operation

## Installation

Add this line to your application's Gemfile:

    gem 'Data_Controller'

And then execute:

    $ bundle 

Or install it yourself as:

    $ gem install Data_Controller

## Usage
    # tow connect to master database you have to connect first
    # see Configuration Database for more details
    DataController::DB::MainDB::Config.connect
     
    data_controller = DataController.new
    
    # :description save data passing to user database
    # :param [Hash] {email:{status:'succ',body:,subject:,email_address:,from:,etc}, 
    #  ship_info:[{ship_name:,port_name:,open_date:},etc]}
    # :return if successful [param] data is returned
    data_controller.successful_email(param)
    
    # :description save data passing to the recovery database.
    # saving an already saved email would result to update the old value.
    # Subject, body and email address of an email is used to generate a unique ID for the email.
    # :param [Hash] {status:'fail',body:,subject:,from:,email_address, date:,etc}        
    data_controller.unsuccessful_email(param)
    
    # :description getting all the emails that have not been successfully recognized
    # :return [Hash] {TODO hash format}
    data_controller.retrieve_unsuccessful_emails

    # :description getting all the emails that have not been successfully recognized
    # :params [String] email address
    # :return [Hash] {TODO hash format}
    data_controller.retrieve_unsuccessful_emails_by_email_address(param)
    
    # :description delete an email
    # :param [String] key of the email
    # :param [String] email address
    # :raise [Aws::DynamoDB::Errors::ValidationException] if no key and email match
    data_controller.delete_unsuccessful_emails(key, email_address)
    
    # :description archive an email
    # :param [String] key of the email
    # :param [String] email address
    # :raise [Aws::DynamoDB::Errors::ValidationException] if no key and email match
    data_controller.archive_unsuccessful_emails(key, email_address)
     
    
---
## Configuration Database
    
    # :description connect to database, to change the default configuration of database please see database.yml file
    # :param platform: ruby, jruby, etc. for now only ruby and jruby supported
    # :param [option Hash] configuration  {'adapter':, 'pool':, 'url':, timeout':, 'host':, 'database':, 'username':, 'password':}
    # if it is not blanked then it will be used. Otherwise it will use database.yml file info
    # :raise [ActiveRecord::AdapterNotSpecified] it may raise exception while establishing a connection
    DataController::DB::MainDB::Config.connect(params) 

    # :description connect to database,
    # to change the default configuration of database please see aws_secrets.yml file
    # :param [option Hash] configuration  {'region':, 'access_key_id':, 'secret_access_key':}
    # if it is not blanked then it will be used. Otherwise it will use aws_secrets.yml file info
    DataController::DB::RecoveryDB::Config.connect(param)
---
The Ship Network @2015
