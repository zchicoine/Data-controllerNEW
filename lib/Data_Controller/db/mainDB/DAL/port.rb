module DataController
    module DB
        module MainDB
            module DAL

                class Port < ActiveRecord::Base
                    # cannot create or modify exciting port
                    def readonly?
                        true
                    end
                end # Port

            end # DAL
        end
    end # DB
end
