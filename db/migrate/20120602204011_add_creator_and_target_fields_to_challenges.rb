class AddCreatorAndTargetFieldsToChallenges < ActiveRecord::Migration
  def up
    add_column :challenges, :user_id, :integer
    add_column :challenges, :email, :string
  end

  def down
    remove_column :challenges, :email
    remove_column :challenges, :user_id
  end
end
