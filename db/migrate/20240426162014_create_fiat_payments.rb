class CreateFiatPayments < ActiveRecord::Migration[7.1]
  def change
    create_table :fiat_payments do |t|
      t.string :uuid, null: false
      t.monetize :amount
      t.references :user, index: true, null: false

      t.timestamps
    end
  end
end
