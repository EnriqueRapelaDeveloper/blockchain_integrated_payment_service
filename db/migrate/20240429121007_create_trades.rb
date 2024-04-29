class CreateTrades < ActiveRecord::Migration[7.1]
  def change
    create_table :trades do |t|
      t.string :uuid, null: false
      t.monetize :original_amount, default: { currency: 'EUR' }
      t.monetize :final_amount, default: { currency: 'USDT' }
      t.references :user, index: true, null: false

      t.timestamps
    end
  end
end
