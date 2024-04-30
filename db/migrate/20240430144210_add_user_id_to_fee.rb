class AddUserIdToFee < ActiveRecord::Migration[7.1]
  def change
    add_reference :fees, :user, null: false, foreign_key: true
  end
end
