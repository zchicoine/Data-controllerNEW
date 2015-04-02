module DataController
    module DB
        module MainDB
            class Shipment < ActiveRecord::Base
                # validation
                validates :port, :presence => true
                validates :ship, :presence => true
                validates :open_start_date, :presence => true

                # relationship
                belongs_to :port
                belongs_to :ship
                has_and_belongs_to_many :brokers
            end
        end
    end # DB
end

