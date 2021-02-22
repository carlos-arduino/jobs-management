class CreateProposals < ActiveRecord::Migration[6.1]
  def change
    create_table :proposals do |t|
      t.integer :status, null: false, default: 0
      t.text :reason
      t.date :start_date
      t.text :message_from_company
      t.string :salary_proposal
      t.references :enrollment, null: false, foreign_key: true

      t.timestamps
    end
  end
end
