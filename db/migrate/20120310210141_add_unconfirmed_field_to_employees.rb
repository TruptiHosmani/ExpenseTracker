class AddUnconfirmedFieldToEmployees < ActiveRecord::Migration
  def change
    add_column :employees, :unconfirmed_email, :string
  end
end
