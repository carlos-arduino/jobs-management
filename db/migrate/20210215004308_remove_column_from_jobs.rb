class RemoveColumnFromJobs < ActiveRecord::Migration[6.1]
  def change
    remove_column :jobs, :domain_id, :integer
  end
end
