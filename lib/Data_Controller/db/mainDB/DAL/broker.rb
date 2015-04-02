require 'active_record'
module DataController
    module DB
        module MainDB
            class Broker < ActiveRecord::Base
                # cannot create or modify exciting broker
                def readonly?
                    true
                end
                # in order to get the shipments that associate to the broker
                has_and_belongs_to_many :shipments
            end
        end
    end # DB
end


