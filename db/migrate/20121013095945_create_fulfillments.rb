class CreateFulfillments < ActiveRecord::Migration
  def change
    create_table :fulfillments do |t|
      t.references :order       , null: false
      t.integer :fulfillment_id
      t.string :tracking_company, limit: 64
      t.string :tracking_number , limit: 64
      t.boolean :received       , default: false
      t.string :receiver        , limit: 32
      t.datetime :received_at
      t.datetime :created_at    , null: false
    end
    add_index :fulfillments, :order_id
  end
end
