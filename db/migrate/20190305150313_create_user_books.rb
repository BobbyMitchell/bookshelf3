class CreateUserBooks < ActiveRecord::Migration[5.1]
  def change
    create_table :user_books do |t|
      t.references :book, foreign_key: true
      t.references :user, foreign_key: true
      t.integer :rating
      t.boolean :have_read

      t.timestamps
    end
  end
end
