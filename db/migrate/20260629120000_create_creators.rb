class CreateCreators < ActiveRecord::Migration[8.1]
  def change
    create_table :creators do |t|
      t.string :email, null: false
      t.string :name, null: false
      t.string :password_digest, null: false

      t.timestamps
    end
    add_index :creators, :email, unique: true
  end
end
