class AddDescriptionToJobs < ActiveRecord::Migration[6.1]
  def change
    add_column :jobs, :description, :text
  end
end
