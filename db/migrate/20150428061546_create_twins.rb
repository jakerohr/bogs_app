class CreateTwins < ActiveRecord::Migration
  def change
    create_table :twins do |t|
      t.string :name
      t.string :position
      t.integer :number
      t.text :bio

      t.timestamps null: false
    end
  end
end
