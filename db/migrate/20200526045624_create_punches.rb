class CreatePunches < ActiveRecord::Migration[6.0]
  def change
    create_table :punches do |t|
      t.integer :job_id
      t.string :notes
      t.timestamp :punch_out
      t.timestamps
    end
  end
end
