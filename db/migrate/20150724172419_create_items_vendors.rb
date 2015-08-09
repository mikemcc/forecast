class CreateItemsVendors < ActiveRecord::Migration
  def change
    create_table :items_vendors do |t|

      t.timestamps null: false
    end
  end
end
