class CreateOptions < ActiveRecord::Migration[5.2]
  def change
    create_table :options do |t|
      t.string :name
      t.integer :easyBonus, default: 150
      t.integer :newInterval, default: 50
      t.integer :intervalModifier, default: 100

      t.timestamps
    end
  end
end
