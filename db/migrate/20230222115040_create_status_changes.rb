class CreateStatusChanges < ActiveRecord::Migration[7.0]
  def change
    create_table :status_changes do |t|
      t.integer :status, null: false, default: STATUS_CREATED
      t.references :user, null: false, foreign_key: true
      t.references :project, null: false, foreign_key: true
      t.timestamps
    end
  end
end
