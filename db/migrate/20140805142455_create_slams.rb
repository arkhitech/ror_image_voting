class CreateSlams < ActiveRecord::Migration
  def change
    create_table :slams do |t|
      t.references :medium_first, index: true
      t.references :medium_second, index: true

      t.timestamps
    end
  end
end
