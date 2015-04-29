require_relative 'data_controller/version'
require_relative 'data_controller/email_forward'
require_relative 'data_controller/retrieve_data'
module DataController

    class << self
        def new
            # Creating a Ruby Class on the fly
            Class.new do
                include Singleton
                include DataController::EmailForward
                include DataController::RetrieveData
            end.instance
        end
    end # self

end