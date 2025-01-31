class CreateVersions < ActiveRecord::Migration[7.1]
  TEXT_BYTES = 1_073_741_823

  def change
    create_table :versions do |t|
      t.string :whodunnit
      t.datetime :created_at
      t.bigint :item_id, null: false
      t.string :item_type, null: false
      t.string :event, null: false
      t.text :object, limit: TEXT_BYTES

      t.index %i[item_type item_id]
    end
  end
end
