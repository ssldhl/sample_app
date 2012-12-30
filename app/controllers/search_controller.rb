class SearchController < ApplicationController
	def index
	end

	def create	
		if params[:commit] =='Sign In'
			if (params[:user][:id] =="")
				flash[:notice] = "Select a username from the list"
				redirect_to root_path
			else
				$name = User.find(params[:user][:id]).name
				redirect_to signin_path
			end
		end

		if params[:commit] == 'Sign Up'
			if (params[:user][:name].empty?)
				flash[:notice] = "Username cannot be left empty"
				redirect_to root_path
			elsif (User.find_by_name(params[:user][:name]))
				flash[:notice] = "This username already exists"
				redirect_to root_path
			else
				$new_name = params[:user][:name]
				redirect_to signup_path
			end
		end
	end

	def edit
	end

	def destroy
	end

	def show
	end

	def new
	end

	def update
	end
end
