class CreateTweets < ActiveRecord::Migration[7.2]
  def change
    create_table :tweets do |t|
      t.string :shop
      t.string :place
      t.string :purpose
      t.string :atomosphere
      t.text :detail

      t.timestamps
    end
  end
end
