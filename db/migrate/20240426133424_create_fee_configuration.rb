class CreateFeeConfiguration < ActiveRecord::Migration[7.1]
  def change
    create_table :fee_configurations do |t|
      t.string :uuid, null: false
      t.boolean :trades, default: true, null: false
      t.float :trades_percentage, default: 1
      t.boolean :payments, default: true, null: false
      t.float :payments_percentage, default: 1
      t.references :user, index: true, null: false

      t.timestamps
    end
  end
end
