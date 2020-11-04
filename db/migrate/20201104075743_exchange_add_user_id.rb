class ExchangeAddUserId < ActiveRecord::Migration[6.0]
  def change
    add_column(:exchanges, :user_id, :bigint)
  end
end
