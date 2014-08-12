class AddCountsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :media_count, :integer
    add_column :users, :followers_count, :integer
    add_column :users, :following_count, :integer
#    add_column :users, :slams_count, :integer
#    add_column :users, :slammables_count, :integer
  end
end
