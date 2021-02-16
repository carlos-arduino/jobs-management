class DropTablePublicDomains < ActiveRecord::Migration[6.1]
  def change
    drop_table :public_domains
  end
end
