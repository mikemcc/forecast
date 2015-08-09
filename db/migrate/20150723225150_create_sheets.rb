class CreateSheets < ActiveRecord::Migration
  def change
    create_table :sheets do |t|
      t.integer :user_id, :null => false
      t.integer :version, :null => false

      t.timestamps null: false
    end
  end
end
