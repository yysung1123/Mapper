class WelcomeController < ApplicationController
	def index
    @input = Input.new
	end

	def about
	end

	def showmap
		@maps = Map.all
	end
end
