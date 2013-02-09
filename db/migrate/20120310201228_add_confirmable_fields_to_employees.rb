class AddConfirmableFieldsToEmployees < ActiveRecord::Migration
  def change
    add_column :employees, :confirmation_token, :string
    add_column :employees, :confirmed_at, :datetime
    add_column :employees, :confirmation_sent_at, :datetime
  end
end
