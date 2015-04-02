module DataController
    module DB
        module MainDB
            class Port < ActiveRecord::Base
                # cannot create or modify exciting port
                def readonly?
                    true
                end
            end # Port
        end
    end # DB
end
