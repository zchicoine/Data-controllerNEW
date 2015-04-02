module DataController
    module DB
        module MainDB
            class Ship < ActiveRecord::Base
                # cannot create or modify exciting Ship
                def readonly?
                    true
                end
            end # Ship
        end
    end # DB
end

