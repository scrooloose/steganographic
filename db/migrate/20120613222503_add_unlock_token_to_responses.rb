class AddUnlockTokenToResponses < ActiveRecord::Migration
  def change
    add_column :responses, :unlock_token, :string
  end
end
