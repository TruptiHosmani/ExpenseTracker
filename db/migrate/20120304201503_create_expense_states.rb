class CreateExpenseStates < ActiveRecord::Migration
  def change
    create_table :expense_states do |t|
      t.string :name

      t.timestamps
    end
  end
end
