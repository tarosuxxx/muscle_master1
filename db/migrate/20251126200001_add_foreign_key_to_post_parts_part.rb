class AddForeignKeyToPostPartsPart < ActiveRecord::Migration[6.1]
  def change
    add_foreign_key :post_parts, :parts
  end
end
