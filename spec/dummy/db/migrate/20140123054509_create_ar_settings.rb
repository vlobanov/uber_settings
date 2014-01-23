class CreateArSettings < ActiveRecord::Migration
  def change
    create_table :ar_settings do |t|
      t.string :name
      t.text :value

      t.timestamps
    end
  end
end
