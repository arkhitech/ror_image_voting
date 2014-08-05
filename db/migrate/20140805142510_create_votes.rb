class CreateVotes < ActiveRecord::Migration
  def change
    create_table :votes do |t|
      t.boolean :vote_status
      t.references :user_id, index: true
      t.references :slam_id, index: true

      t.timestamps
    end
  end
end
