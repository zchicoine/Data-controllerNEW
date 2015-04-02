require 'Data_Controller/version'
require 'db/mainDB/mainDB_config'
require 'db/recoveryDB/recoveryDB_config'
require 'db/mainDB/DAL/broker'
require 'db/mainDB/DAL/shipment'
require 'db/recoveryDB/DAL/email'
module DataController
    include MainDBConfig
    include RecoveryDBConfig

    ### TODO clean this
   # a =  RecoveryDBConfig.connect
   # p a.operation_names

    # a = Email.new(
    #     {
    #         review_by:'mo',
    #         status:'f',
    #         subject:'teSst',
    #         body:'It is a test',
    #         email_address:'example@.com',
    #         date: DateTime.now.to_s
    #     }
    # )
    #
    # a.save
    #p Email.find_all_by_email_address('example@.com')



    # MainDBConfig.connect
    # broker = Broker.last
    # p broker.username
    # shipment = Shipment.take(10)
    # shipment.each do |ship|
    #      ship
    # end
    # p broker.shipments


end