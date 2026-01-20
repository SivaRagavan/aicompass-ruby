class AddCancelledAtToAssessments < ActiveRecord::Migration[8.1]
  def change
    add_column :assessments, :cancelled_at, :datetime
  end
end
