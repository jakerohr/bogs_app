class CreateTagsTwins < ActiveRecord::Migration
  def change
    create_table :tags_twins do |t|
      t.references :twin, index: true, foreign_key: true
      t.references :tag, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
