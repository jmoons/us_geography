class CreateCounties < ActiveRecord::Migration[5.1]
  def change
    create_table :counties do |t|
      t.string :name
      t.belongs_to :state
      t.timestamps
    end
  end
end
