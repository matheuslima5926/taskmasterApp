class CreateProjects < ActiveRecord::Migration[5.2]
  def change
    create_table :projects do |t|
      t.string :name
      t.references :user, foreign_key: true
      t.boolean :done, default: false
      t.datetime :start_date
      t.datetime :finished_date

      t.timestamps
    end
  end
end
