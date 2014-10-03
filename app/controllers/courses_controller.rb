class CoursesController < ApplicationController
  before_action :authenticate_user!, except: [:index]


	def index
		@courses = Course.all
	end

end
