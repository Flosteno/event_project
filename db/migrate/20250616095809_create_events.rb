class CreateEvents < ActiveRecord::Migration[8.0]
  def change
    create_table :events do |t|
      t.datetime :start_date, null: false
      t.integer :duration, null: false
      t.string :title, null: false
      t.text :description, null: false
      t.integer :price, null: false
      t.string :location, null: false
      t.references :admin, foreign_key: { to_table: :users }

      t.timestamps
    end
  end
end
