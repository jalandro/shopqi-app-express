class CreateTrackings < ActiveRecord::Migration
  def change
    create_table :trackings do |t|
      t.references :fulfillment
      t.datetime :time , null: false
      t.string :context, null: false
    end
    add_index :trackings, :fulfillment_id
  end
end
