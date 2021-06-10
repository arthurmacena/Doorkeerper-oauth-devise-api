class AddNewFieldsToUser < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :first_name, :string
    add_column :users, :last_name, :string
    add_column :users, :birthdate, :date
    add_column :users, :cpf, :string
    add_column :users, :phone, :string
 
    add_column :users, :adress, :string
    add_column :users, :cep, :string
    add_column :users, :complement, :string
    add_column :users, :neighborhood, :string
    add_column :users, :number, :integer
    add_column :users, :city, :string
    add_column :users, :state, :string
    add_column :users, :country, :string
  end
end
