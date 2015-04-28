require_relative '../recoveryDB_config'

module DataController
    module DB
        module RecoveryDB
            module DAL

                class AbstractModel
                    include RecoveryDBConfig

                    class << self
                        @@table_name = ''
                        # :description connect to Aws::DynamoDB
                        # :return
                        def dynamodb
                            @@dynamodb = RecoveryDBConfig.connect
                        end

                        # :return [String] table name
                        def table_name
                            @@table_name
                        end

                        # :param [String] table name
                        # :return [String] table name
                        def table_name=(name)
                            @@table_name = name
                        end
                    end # class self


                    # :overwrite
                    def initialize(params = {})

                    end

                    # save to database
                    def save

                    end
                end

            end
        end
    end
end