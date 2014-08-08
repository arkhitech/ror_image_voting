class CreateMembers < ActiveRecord::Migration
  def change
    create_table :members do |t|
      t.references :user, index: true
      t.references :user_group, index: true

      t.timestamps
    end
  end
end
