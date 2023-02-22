class CreateActivities < ActiveRecord::Migration[7.0]
  def change
    create_table :activities do |t|
      t.references :activitiable, polymorphic: true, null: false
      t.references :project, null: false, foreign_key: true

      t.timestamps
    end
  end
end
