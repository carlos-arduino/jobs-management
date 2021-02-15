class ChangeStatusFromJobs < ActiveRecord::Migration[6.1]
  def change
    change_column_default :jobs, :status, from: nil, to: 0
  end
end
