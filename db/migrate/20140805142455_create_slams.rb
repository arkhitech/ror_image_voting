class CreateSlams < ActiveRecord::Migration
  def change
    create_table :slams do |t|
      t.references :media_id_first, index: true
      t.references :media_id_second, index: true

      t.timestamps
    end
  end
end
