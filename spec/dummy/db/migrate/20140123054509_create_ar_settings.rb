class CreateArSettings < ActiveRecord::Migration
  def change
    create_table :ar_settings do |t|
      t.string :name
      t.text :value
      t.string :value_type
      t.timestamps
    end
  end
end
