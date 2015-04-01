class ShipDetail < ActiveRecord::Base
    # cannot create or modify exciting ShipDetail
    def readonly?
        true
    end
end
