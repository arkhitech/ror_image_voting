class CreateGroupShares < ActiveRecord::Migration
  def change
    create_table :group_shares do |t|
      t.references :user_group, index: true
      t.references :medium, index: true

      t.timestamps
    end
  end
end
