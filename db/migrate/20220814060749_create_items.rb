class CreateItems < ActiveRecord::Migration[6.1]
  def change
    create_table :items do |t|
      t.references :genre, foreign_key: true,  null: false
      t.string  :name,  null: false
      t.text    :explanation, null: false
      t.integer :price, null: false
      t.boolean :is_ordered, null: false, default: true

      t.timestamps
    end
  end
end
