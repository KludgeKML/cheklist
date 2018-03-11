class CreateVariables < ActiveRecord::Migration[5.2]
  def change
    create_table :variables do |t|
      t.string :name
      t.string :variable
      t.references :check, foreign_key: true

      t.timestamps
    end
  end
end
