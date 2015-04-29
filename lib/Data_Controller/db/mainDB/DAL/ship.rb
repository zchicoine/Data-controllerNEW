module DataController
    module DB
        module MainDB
            module DAL
                class Ship < ActiveRecord::Base
                    # cannot create or modify exciting Ship
                    def readonly?
                        true
                    end
                end # Ship

            end # DAL
        end
    end # DB
end

