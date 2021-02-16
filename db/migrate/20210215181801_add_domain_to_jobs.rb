class AddDomainToJobs < ActiveRecord::Migration[6.1]
  def change
    add_column :jobs, :domain, :string
  end
end
