class CreatePagesTags < ActiveRecord::Migration[5.0]
  def change
    create_table :pages_tags do |t|
      t.integer :page_id
      t.integer :tag_id

      t.timestamps
    end
  end
end
