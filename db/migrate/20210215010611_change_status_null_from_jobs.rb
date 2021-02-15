class ChangeStatusNullFromJobs < ActiveRecord::Migration[6.1]
  def change
    change_column_null :jobs, :status, false
  end
end
