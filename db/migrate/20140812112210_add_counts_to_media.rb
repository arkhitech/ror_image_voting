class AddCountsToMedia < ActiveRecord::Migration
  def change
    add_column :media, :slams_count, :integer
    add_column :media, :slammables_count, :integer
  end
end
