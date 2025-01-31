class CreateUsers < ActiveRecord::Migration[7.1]
  def change
    create_user_table
    add_user_indexes
  end

  private

  def create_user_table
    create_table :users do |t|
      ## Required fields
      t.string :provider, null: false, default: 'email'
      t.string :uid, null: false, default: ''

      ## Database authenticatable
      t.string :encrypted_password, null: false, default: ''

      ## Recoverable fields
      t.string   :reset_password_token
      t.datetime :reset_password_sent_at
      t.boolean  :allow_password_change, default: false, null: false

      ## Rememberable
      t.datetime :remember_created_at

      ## User Info
      t.string :name
      t.string :nickname
      t.string :image
      t.string :email, null: false, default: ''

      ## Tokens
      t.json :tokens

      ## Type (needed for STI)
      t.string :type

      t.timestamps
    end
  end

  def add_user_indexes
    add_index :users, :email, unique: true
    add_index :users, %i[uid provider], unique: true
    add_index :users, :reset_password_token, unique: true
    add_index :users, :type
  end
end
