class AddForBeginnersFlagToChallanges < ActiveRecord::Migration
  def change
    add_column :challenges, :for_beginners, :boolean
  end
end
