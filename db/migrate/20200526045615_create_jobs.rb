class CreateJobs < ActiveRecord::Migration[6.0]
  def change
    create_table :jobs do |t|
      t.string :name
      t.text :description
      t.boolean :completed,		default: false	
      t.boolean :status,		default: true
      t.integer :user_id
      t.timestamps
    end
  end
end
