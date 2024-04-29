class CreateFees < ActiveRecord::Migration[7.1]
  def change
    create_table :fees do |t|
      t.string :uuid, null: false
      t.monetize :amount, default: { currency: 'EUR' }
      t.references :transactionable, polymorphic: true, null: false
      t.boolean :paid, null: false

      t.timestamps
    end
  end
end
