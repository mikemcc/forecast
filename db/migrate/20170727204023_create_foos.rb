class CreateFoos < ActiveRecord::Migration
  def change
    create_table :foos do |t|
      t.string :name
      t.string :color
      t.string :body

      t.timestamps null: false
    end
  end
end
