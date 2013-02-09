class CreateExpenseTypes < ActiveRecord::Migration
  def change
    create_table :expense_types do |t|
      t.string :name
      t.float :max_expensable

      t.timestamps
    end
  end
end
