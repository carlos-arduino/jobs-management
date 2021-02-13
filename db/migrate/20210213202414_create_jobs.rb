class CreateJobs < ActiveRecord::Migration[6.1]
  def change
    create_table :jobs do |t|
      t.string :title
      t.string :income
      t.integer :level
      t.date :limit_date
      t.integer :quantity
      t.integer :status
      t.references :domain, null: false, foreign_key: true

      t.timestamps
    end
  end
end
