class CreateAssessments < ActiveRecord::Migration[8.1]
  def change
    create_table :assessments do |t|
      t.references :user, null: false, foreign_key: true
      t.string :company_name, null: false
      t.string :company_industry
      t.string :company_size
      t.string :invite_token, null: false
      t.datetime :invite_expires_at, null: false
      t.string :status, null: false, default: "active"
      t.jsonb :exec_profile, null: false, default: {}
      t.jsonb :selections, null: false, default: []
      t.jsonb :scores, null: false, default: []
      t.jsonb :responses, null: false, default: {}
      t.jsonb :progress_data, null: false, default: {}

      t.timestamps
    end

    add_index :assessments, :invite_token, unique: true
  end
end
