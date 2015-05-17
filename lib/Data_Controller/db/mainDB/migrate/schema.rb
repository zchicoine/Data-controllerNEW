###
# this schema will never be used to create tables.
# It purposes to make attributes recognize by ActiveRecode for each model
###
module DataController
    module DB
        module MainDB
            class Schema < ActiveRecord::Migration

                def change

                    #########============================================= ships ====================================================#########
                    create_table :ships do |t|
                        t.string :name
                        t.integer :deadweight
                        t.integer :deadweight_cargo_capacity
                        t.integer :vessel_type , default: 0
                        t.integer :vessel_category, default: 0

                        t.timestamps
                    end
                    add_index :ships, :name, :unique => true
                    #########============================================= end ships ====================================================#########

                    #########============================================= brokers_shipments ====================================================#########
                    create_table :brokers_shipments , id: false do |t|
                        t.belongs_to :shipment
                        t.belongs_to :broker
                    end
                    #########============================================= end brokers_shipments ====================================================#########

                    #########============================================= ports ====================================================#########
                    create_table :ports do |t|
                        t.string :name
                        t.float :latitude
                        t.float :longitude
                        t.string :region

                        t.timestamps
                    end
                    add_index :ports, :name, :unique => true
                    #########============================================= end ports ====================================================#########

                    #########============================================= shipments ====================================================#########
                    create_table :shipments do  |t|
                        t.belongs_to :ship
                        t.belongs_to :port
                        t.date :open_start_date, null: false
                        t.date :open_end_date

                        t.timestamps
                    end
                    add_index 'shipments', %w(ship_id port_id), :unique => true
                    #########============================================= end shipments ====================================================#########

                    #########============================================= brokers ====================================================#########
                    create_table(:brokers) do |t|
                        ## Database authenticatable
                        t.string :email,              null: false, default: ""
                        t.string :username
                        t.string :encrypted_password, null: false, default: ""
                        t.boolean :admin, null: true, default: false
                        # broker info
                        t.string :company
                        t.string :website
                        t.string :telephone
                        t.string :country
                        t.string :city
                        # broker status
                        t.integer :ship_emails
                        t.integer :personal_emails
                        t.integer :order_emails
                        t.integer :not_ship_emails
                        ## Recoverable
                        t.string   :reset_password_token
                        t.datetime :reset_password_sent_at

                        ## Rememberable
                        t.datetime :remember_created_at

                        ## Trackable
                        # t.integer  :sign_in_count, default: 0, null: false
                        # t.datetime :current_sign_in_at
                        # t.datetime :last_sign_in_at
                        # t.string   :current_sign_in_ip
                        # t.string   :last_sign_in_ip

                        ## Confirmable
                        # t.string   :confirmation_token
                        # t.datetime :confirmed_at
                        # t.datetime :confirmation_sent_at
                        # t.string   :unconfirmed_email # Only if using reconfirmable

                        ## Lockable
                        # t.integer  :failed_attempts, default: 0, null: false # Only if lock strategy is :failed_attempts
                        # t.string   :unlock_token # Only if unlock strategy is :email or :both
                        # t.datetime :locked_at


                        t.timestamps
                    end

                    add_index :brokers, :email,                unique: true
                    add_index :brokers, :reset_password_token, unique: true
                    add_index :brokers, :username, unique: true
                    # add_index :brokers, :confirmation_token,   unique: true
                    # add_index :brokers, :unlock_token,         unique: true
                    #########============================================= end brokers ====================================================#########

                    #########============================================= brokers shipment ====================================================#########
                    create_table :brokers_shipments , id: false do |t|
                        t.belongs_to :shipment
                        t.belongs_to :broker
                    end
                    #########============================================= end brokers shipment ====================================================#########

                    #########============================================= ship email ====================================================#########
                    create_table :ship_emails do |t|
                        # the reason why email information is here because
                        #  each email can have multiple shipments,
                        #  and each shipment can have multiple brokers
                        t.string :email_body , null: false
                        t.string :email_subject , null: false
                        t.string :original_email_address # email address of the original sender
                        t.date :email_date , null: false
                        t.integer :broker_id
                    end
                    add_index :ship_emails, :broker_id
                    #########============================================= end ship email ====================================================#########

                    #########============================================= ship email shipment ====================================================#########
                    create_table :ship_emails_shipments , id: false  do |t|
                        t.belongs_to :shipment
                        t.belongs_to :ship_email
                    end
                    #########============================================= end ship email shipment ====================================================#########

                end
            end # Schema
        end # MainDB
    end # DB
end # DataController