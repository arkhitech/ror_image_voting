class CreateGroupShares < ActiveRecord::Migration
  def change
    create_table :group_shares do |t|
      t.references :group, index: true
      t.references :media, index: true

      t.timestamps
    end
  end
end
