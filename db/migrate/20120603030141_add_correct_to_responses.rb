class AddCorrectToResponses < ActiveRecord::Migration
  def up
    add_column :responses, :correct, :boolean
  end

  def down
    remove_column :responses, :correct
  end
end
