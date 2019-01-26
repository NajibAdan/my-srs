class CreateFronts < ActiveRecord::Migration[5.2]
  def change
    create_table :fronts do |t|
      t.string "text_field"
      t.timestamps
    end
  end
end
