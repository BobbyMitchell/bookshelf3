class AddFieldToBooks < ActiveRecord::Migration[5.1]
  def change
    add_column :books, :genre, :string
    add_column :books, :description, :text
    add_column :books, :isbn, :bigint
    add_column :books, :page_count, :integer
  end
end
