class Ship < ActiveRecord::Base
    # cannot create or modify exciting Ship
    def readonly?
        true
    end
end
