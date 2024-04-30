class ChangeMoneyColumns < ActiveRecord::Migration[7.1]
  def change
    remove_column :blockchain_payments, :amount_cents
    remove_column :blockchain_payments, :amount_currency
    remove_column :trades, :original_amount_cents
    remove_column :trades, :original_amount_currency
    remove_column :trades, :final_amount_cents
    remove_column :trades, :final_amount_currency

    add_column :blockchain_payments, :amount_cents, :float
    add_column :blockchain_payments, :amount_currency, :string
    add_column :trades, :original_amount_cents, :float
    add_column :trades, :original_amount_currency, :string
    add_column :trades, :final_amount_cents, :float
    add_column :trades, :final_amount_currency, :string
  end
end
