class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :nickname
      t.string :comment
      t.string :image_url

      t.timestamps
    end
  end
end
