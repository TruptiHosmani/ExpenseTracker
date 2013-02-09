class CreateDepartments < ActiveRecord::Migration
  def change
    create_table :departments do |t|
      t.string :name
      t.integer :no_of_employees
      t.float :budget

      t.timestamps
    end
  end
end
