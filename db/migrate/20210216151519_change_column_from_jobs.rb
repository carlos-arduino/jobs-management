class ChangeColumnFromJobs < ActiveRecord::Migration[6.1]
  def change
    change_column :jobs, :level, :string
    change_column :jobs, :description, :text
  end
end
