module DataController
    module DB
        module MainDB
            class ShipDetail < ActiveRecord::Base
                # cannot create or modify exciting ShipDetail
                def readonly?
                    true
                end
            end # ShipDetail
        end
    end # DB
end
