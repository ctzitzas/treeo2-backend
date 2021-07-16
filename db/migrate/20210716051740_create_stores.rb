class CreateStores < ActiveRecord::Migration[6.1]
  def change
    create_table :stores do |t|
      t.string :name
      t.string :address
      t.string :suburb
      t.string :state
      t.string :postcode

      t.timestamps
    end
  end
end
