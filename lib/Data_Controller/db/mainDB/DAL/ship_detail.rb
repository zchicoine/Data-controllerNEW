module DataController
    module DB
        module MainDB
            module DAL
                class ShipDetail < ActiveRecord::Base
                    # cannot create or modify exciting ShipDetail
                    def readonly?
                        true
                    end
                end # ShipDetail

            end # DAL
        end
    end # DB
end
