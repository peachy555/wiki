class RenameScoreToUserId < ActiveRecord::Migration[5.0]
  def change
    rename_column :tag_weights, :score, :user_id
  end
end
