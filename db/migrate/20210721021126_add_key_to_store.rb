class AddKeyToStore < ActiveRecord::Migration[6.1]
  def change
    add_column :stores, :key, :string
  end
end
