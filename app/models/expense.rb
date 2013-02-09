class Expense < ActiveRecord::Base
  belongs_to :employee
  belongs_to :expense_type
  belongs_to :payment_mode
  belongs_to :vendor
  belongs_to :expense_state
  has_attached_file :receipt
end
