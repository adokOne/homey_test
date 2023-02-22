class CreateProjects < ActiveRecord::Migration[7.0]
  def change
    create_table :projects do |t|
      t.string :name
      t.text :description
      t.integer :status, null: false, default: STATUS_CREATED
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
