class CreatePotatos < ActiveRecord::Migration[6.0]
  def change
    create_table :potatos do |t|
      t.float :value
      t.datetime :time
    end
  end
end