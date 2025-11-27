class CreatePostParts < ActiveRecord::Migration[6.1]
  def change
    create_table :post_parts do |t|
      t.references :post, null: false, foreign_key: true
      t.references :part, null: false

      t.timestamps
    end
  end
end
