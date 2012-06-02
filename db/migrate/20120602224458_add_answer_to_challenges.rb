class AddAnswerToChallenges < ActiveRecord::Migration
  def up
    add_column :challenges, :answer, :text
  end

  def down
    remove_column :challenges, :answer
  end
end
