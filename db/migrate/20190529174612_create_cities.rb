class CreateCities < ActiveRecord::Migration[5.1]
  def change
    create_table :cities do |t|
      t.string :name
      t.belongs_to :state
      t.belongs_to :county
      t.timestamps
    end
  end
end
