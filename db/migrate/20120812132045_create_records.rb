class CreateRecords < ActiveRecord::Migration
  def change
    create_table :records do |t|
      t.date :day
      t.string :item
      t.decimal :expense
      t.decimal :income
      t.string :tag
      t.text :remark

      t.timestamps
    end
  end
end
