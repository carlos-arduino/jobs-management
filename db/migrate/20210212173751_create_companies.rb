class CreateCompanies < ActiveRecord::Migration[6.1]
  def change
    create_table :companies do |t|
      t.string :name
      t.string :address
      t.string :cnpj
      t.string :site
      t.string :social_midia
      t.string :domain
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
