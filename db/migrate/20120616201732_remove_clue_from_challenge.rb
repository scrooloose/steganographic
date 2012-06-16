class RemoveClueFromChallenge < ActiveRecord::Migration
  def change
    remove_column :challenges, :clue
  end
end
