
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
        create_table :shipments do |t|
            t.integer :port_id
            t.integer :ship_id
            t.date :open_start_date
            t.date :open_end_date

            t.timestamps
        end
        # add_index lines make it faster to access information via the join model
        add_index :shipments, :port_id
        add_index :shipments, :ship_id
        #########============================================= end shipments ====================================================#########

        #########============================================= brokers ====================================================#########
        create_table(:brokers) do |t|
            ## Database authenticatable
            t.string :email,              null: false, default: ""
            t.string :username
            t.string :encrypted_password, null: false, default: ""
            t.boolean :admin, null: true, default: false
            t.string :company
            t.string :website
            t.string :telephone
            t.string :country
            t.string :city
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

    end
end