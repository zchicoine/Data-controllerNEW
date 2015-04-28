require 'aws-sdk'
require 'aws-sdk-core/dynamodb'
module RecoveryDBConfig

    class << self
        def connect
            # load credentials from disk
            creds = YAML.load(File.read('Data_Controller/db/recoveryDB/aws_secrets.yml'))
            Aws::DynamoDB::Client.new(
                region: 'us-east-1',
                access_key_id: creds['access_key_id'],
                secret_access_key: creds['secret_access_key']
            )
        end
    end


end