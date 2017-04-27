class CreateTasks < ActiveRecord::Migration[5.0]
  def change
    create_table :tasks do |t|
      t.string :todo
      t.datetime :expire
      t.boolean :published, default: true
      t.boolean :finished, default: false
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
