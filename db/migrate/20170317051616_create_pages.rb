class CreatePages < ActiveRecord::Migration[5.0]
  def change
    create_table :pages do |t|
      t.string :name
      t.integer :topic_id
      t.string :free_content
      t.string :member_content

      t.timestamps
    end
  end
end
