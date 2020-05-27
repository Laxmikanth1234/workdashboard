class CreateClocks < ActiveRecord::Migration[6.0]
  def change
    create_table :clocks do |t|
      t.timestamp :clock_out
      t.integer :user_id
      t.timestamps
    end
  end
end
