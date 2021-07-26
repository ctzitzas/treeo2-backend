class CreatePurchases < ActiveRecord::Migration[6.1]
  def change
    create_table :purchases do |t|
      t.string :receipt_url
      t.string :payment_intent_id
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
