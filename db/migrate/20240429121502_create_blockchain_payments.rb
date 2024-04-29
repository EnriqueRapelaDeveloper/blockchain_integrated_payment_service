class CreateBlockchainPayments < ActiveRecord::Migration[7.1]
  def change
    create_table :blockchain_payments do |t|
      t.string :uuid, null: false
      t.float :amount
      t.string :currency
      t.references :user, index: true, null: false

      t.timestamps
    end
  end
end
