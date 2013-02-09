class CreatePaymentModes < ActiveRecord::Migration
  def change
    create_table :payment_modes do |t|
      t.string :name
      t.float :max_allowed

      t.timestamps
    end
  end
end
