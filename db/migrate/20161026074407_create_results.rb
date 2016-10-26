class CreateResults < ActiveRecord::Migration
  def change
    create_table :results do |t|
      t.string :comment

      t.timestamps null: false
    end
  end
end
