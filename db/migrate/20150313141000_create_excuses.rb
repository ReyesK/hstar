class CreateExcuses < ActiveRecord::Migration
  def change
    create_table :excuses do |t|
      t.text :excuse
      t.timestamps
    end
  end
end
