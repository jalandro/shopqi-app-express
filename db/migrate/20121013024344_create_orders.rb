class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.references :shop               , null: false
      t.integer :order_id              , null: false, unique: true
      t.string :name                   , null: false, limit: 32
    end
    add_index :orders, :order_id, unique: true
  end
end
