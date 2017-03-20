class CreateTagWeights < ActiveRecord::Migration[5.0]
  def change
    create_table :tag_weights do |t|
      t.integer :page_id
      t.integer :tag_id
      t.integer :score

      t.timestamps
    end
  end
end
