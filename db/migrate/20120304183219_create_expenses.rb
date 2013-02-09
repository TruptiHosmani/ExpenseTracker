class CreateExpenses < ActiveRecord::Migration
  def change
    create_table :expenses do |t|
      t.date :date
      t.string :description
      t.float :amount
      t.references :employee
      t.references :expense_type
      t.references :payment_mode
      t.references :vendor
      t.binary :receipt

      t.timestamps
    end
    add_index :expenses, :employee_id
    add_index :expenses, :expense_type_id
    add_index :expenses, :payment_mode_id
    add_index :expenses, :vendor_id
  end
end
