class AddEmoCountToPosts < ActiveRecord::Migration[7.2]
  def change
    add_column :posts, :emo_count, :integer, default: 0
  end
end
