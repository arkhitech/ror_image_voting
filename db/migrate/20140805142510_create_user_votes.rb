class CreateUserVotes < ActiveRecord::Migration
  def change
    create_table :user_votes do |t|
      t.boolean :vote_status
      t.references :user, index: true
      t.references :slam, index: true

      t.timestamps
    end
  end
end
