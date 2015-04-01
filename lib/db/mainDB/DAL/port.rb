class Port < ActiveRecord::Base
    # cannot create or modify exciting port
    def readonly?
        true
    end
end
