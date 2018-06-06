class CreateCredentials < ActiveRecord::Migration[5.2]
  def change
    create_table :credentials do |t|
      t.string :username
      t.string :apikey
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
