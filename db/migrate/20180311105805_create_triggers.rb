class CreateTriggers < ActiveRecord::Migration[5.2]
  def change
    create_table :triggers do |t|
      t.string :description
      t.string :target
      t.string :action
      t.references :repository, foreign_key: true

      t.timestamps
    end
  end
end
