class AddProfileInfoColumns < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :name, :string, default: 'name'
    add_column :users, :bio, :text
    add_column :users, :birthday, :date, default: Date.today
    add_column :users, :color, :string
    add_column :users, :animal, :string
    add_column :users, :food, :string
  end
end
