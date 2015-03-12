class CreateWords < ActiveRecord::Migration
  def change
    create_table :words do |t|
      t.string :text
      t.string :type
      t.string :article
      t.timestamps
    end
  end
end
