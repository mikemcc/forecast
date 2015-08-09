class CreateItems < ActiveRecord::Migration
  def change
    create_table :items do |t|
      t.string  :name, :null => false
      t.integer :user_id, :null => false
      t.integer :vendor_id, :null => false
      t.integer :sheet_id, :null => false
      t.integer :version, :default => 0
      t.integer :january, :default => 0
      t.integer :february, :default => 0
      t.integer :march, :default => 0
      t.integer :april, :default => 0
      t.integer :may, :default => 0
      t.integer :june, :default => 0
      t.integer :july, :default => 0
      t.integer :august, :default => 0
      t.integer :september, :default => 0
      t.integer :october, :default => 0
      t.integer :november, :default => 0
      t.integer :december, :default => 0
      t.string  :signature
      t.timestamps null: false
    end
  end
end
