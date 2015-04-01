class Shipment < ActiveRecord::Base
    # validation
    validates :port, :presence => true
    validates :ship, :presence => true

    # relationship
    belongs_to :port
    belongs_to :ship
    has_and_belongs_to_many :brokers
end
