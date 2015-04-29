require 'aws-sdk'
require 'aws-sdk-core/dynamodb'
module DataController
    module DB
        module RecoveryDB
            module Config

                class << self
                    # :description connect to database, to change the default configuration of database please see aws_secrets.yml file
                    # :param [option Hash] configuration  {'region':, 'access_key_id':, 'secret_access_key':}
                    # if it is not blanked then it will be used. Otherwise it will use aws_secrets.yml file info
                    # :raise it may raise exception while establishing a connection
                    def connect(configuration = {})
                        if configuration.keys.blank?
                            # load credentials from disk
                            creds = YAML.load(File.read('lib/Data_Controller/db/recoveryDB/aws_secrets.yml'))
                            Aws::DynamoDB::Client.new(
                                region: 'us-east-1',
                                access_key_id: creds['access_key_id'],
                                secret_access_key: creds['secret_access_key']
                            )
                        else
                            Aws::DynamoDB::Client.new(
                                region: configuration['region'],
                                access_key_id: configuration['access_key_id'],
                                secret_access_key: configuration['secret_access_key']
                            )
                        end

                    end
                end

            end
        end
    end
end
