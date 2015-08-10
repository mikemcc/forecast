class CreatePayloads < ActiveRecord::Migration
  def change
    create_table :payloads do |t|
      t.text :contents
      t.integer :user_id, null: false

      t.timestamps null: false
    end
  end
end
