class AddPronounToWords < ActiveRecord::Migration
  def change
    add_column :words, :pronoun, :string
  end
end
