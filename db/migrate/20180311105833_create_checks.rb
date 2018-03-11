class CreateChecks < ActiveRecord::Migration[5.2]
  def change
    create_table :checks do |t|
      t.string :description
      t.string :type
      t.references :trigger, foreign_key: true

      t.timestamps
    end
  end
end
