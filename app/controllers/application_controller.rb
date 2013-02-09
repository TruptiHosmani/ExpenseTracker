class ApplicationController < ActionController::Base
  protect_from_forgery

   def only_for_managers
    if current_employee.subordinates.count == 0
     flash[:error] = "You must be Manager  to access this section" 
      redirect_to '/' # halts request cycle
    end
   end

end
