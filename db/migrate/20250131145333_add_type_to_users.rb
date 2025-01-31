class AddTypeToUsers < ActiveRecord::Migration[7.1]
  def change
    add_index :users, :type unless index_exists?(:users, :type)
  end
end
