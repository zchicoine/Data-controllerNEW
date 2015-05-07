module DataController
    module DB
        module MainDB
            module DAL
                # ActiveRecord throw an exception when using require or require_relative
                # The exception is "ActiveSupport::Concern::MultipleIncludedBlocks: Cannot define multiple 'included' blocks for a Concern"
                # So the code has moved to data_controller.rb file
            end # DAL
        end
    end # DB
end


