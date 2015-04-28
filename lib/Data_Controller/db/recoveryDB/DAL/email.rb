require_relative 'abstract_model'

module DataController
    module DB
        module RecoveryDB
            module DAL
                class Email < AbstractModel

                    # table name
                    Email.table_name = 'UnRecognizeEmails'

                    class << self

                        # :params [String] email address
                        # :return [TODO return format]
                        def find_all_by_email_address(email_address)
                            dynamodb.scan(:table_name => self.table_name,
                                           :scan_filter => {
                                               email_address: {
                                                   attribute_value_list: [email_address],
                                                   comparison_operator: 'EQ'
                                               }
                                           }
                            ).data
                        end

                        # :return [TODO return format]
                        #   all the items and their attributes
                        #   If the total number of scanned items exceeds the maximum data set size limit of 1 MB
                        def find_all
                            dynamodb.scan(table_name:self.table_name).data
                        end
                    end

                    attr_accessor :email_hash

                    # :params [Hash] {subject:,body:,email_address,date:,status:,etc} TODO write the format of param hash
                    # :raise [ArgumentError] body and email_address cannot be nil
                    # :return [self]
                    def initialize(params = {})

                        if params[:body].nil? or params[:email_address].nil?
                            raise ArgumentError.new('body and email_address cannot be nil')
                        end

                        @email_hash = {}
                        @email_hash[:subject] = params[:subject]
                        @email_hash[:body] = params[:body]
                        @email_hash[:date] = params[:date]
                        @email_hash[:email_address] = params[:email_address]
                        @email_hash[:status] =  params[:status]
                        @email_hash[:extra] = {
                            ReviewBy: params[:review_by]
                        }

                        self
                    end

                    # :description save to database (for more info see
                    # http://docs.aws.amazon.com/sdkforruby/api/Aws/DynamoDB/Client.html#put_item-instance_method)
                    # saving an already saved email would result to update the old value.
                    # Subject, body and email address of an email is used to generate a unique ID for the email.
                    # :raise [Errors::InternalServerError] from aws-sdk gem
                    # :return the saved value
                    def save
                        @email_hash[:Key] = hash_id
                        Email.dynamodb.put_item(:table_name => Email.table_name, :item => @email_hash)
                    end

                    private

                    # :description hashed a string to be use as Key for aws dynamoDB
                    # :return a hashed string obtains from subject, email address and date
                    def hash_id
                        str = "#{@email_hash[:subject]} #{@email_hash[:body]} #{@email_hash[:email_address]}"
                         Digest::MD5.hexdigest(str)
                    end
                end

            end
        end
    end
end