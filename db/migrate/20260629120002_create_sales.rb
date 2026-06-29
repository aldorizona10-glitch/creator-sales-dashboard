class CreateSales < ActiveRecord::Migration[8.1]
  def change
    create_table :sales do |t|
      t.references :creator, null: false, foreign_key: true
      t.references :product, null: false, foreign_key: true
      t.string :buyer_email, null: false
      t.integer :amount_cents, null: false
      t.string :currency, null: false, default: "USD"
      t.datetime :refunded_at

      t.timestamps
    end
    add_index :sales, :created_at
  end
end
