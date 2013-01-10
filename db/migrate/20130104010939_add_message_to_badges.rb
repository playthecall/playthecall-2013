class AddMessageToBadges < ActiveRecord::Migration
  def change
    add_column :badges, :message, :text
  end
end
