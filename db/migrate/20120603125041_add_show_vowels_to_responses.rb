class AddShowVowelsToResponses < ActiveRecord::Migration
  def up
    add_column :responses, :show_vowels, :boolean
  end

  def down
    remove_column :responses, :show_vowels
  end
end
