require_relative 'abstract_model'

class Email < AbstractModel

    # table name
    Email.table_name = 'UnRecognizeEmails'

    class << self

        # :params [String] email address
        def find_all_by_email_address(email_address)
            dynamodb.scan(:table_name => self.table_name,
                           :scan_filter => {
                               Email_address: {
                                   attribute_value_list: [email_address],
                                   comparison_operator: 'EQ'
                               }
                           }
            ).data
        end

        def find_all
            dynamodb.scan(table_name:self.table_name).data
        end
    end

    attr_accessor :email_hash

    # :params [Hash] {subject:,body:,email_address,date:,status:,etc} TODO write the format of param hash
    # :return [self]
    def initialize(params = {})

        if params[:body].nil? or params[:email_address].nil?
            raise ArgumentError.new('body and email_address cannot be nil')
        end

        @email_hash = {}
        @email_hash[:Subject] = params[:subject]
        @email_hash[:Body] = params[:body]
        @email_hash[:Date] = params[:date]
        @email_hash[:Email_address] = params[:email_address]
        @email_hash[:Extra] = {
            Status: params[:status],
            ReviewBy: params[:review_by]
        }

        self
    end

    # save to database
    def save
        @email_hash[:Key] = hash_id
        Email.dynamodb.put_item(:table_name => Email.table_name, :item => @email_hash)
    end

    private

    # :description hashed a string to be use as Key for aws dynamoDB
    # :return a hashed string obtains from subject, email address and date
    def hash_id
        str = "#{@email_hash[:Subject]} #{@email_hash[:body]} #{@email_hash[:email_address]}"
         Digest::MD5.hexdigest(str)
    end
end