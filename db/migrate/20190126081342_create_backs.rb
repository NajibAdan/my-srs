class CreateBacks < ActiveRecord::Migration[5.2]
  def change
    create_table :backs do |t|
      t.string "text_field"
      t.timestamps
    end
  end
end
