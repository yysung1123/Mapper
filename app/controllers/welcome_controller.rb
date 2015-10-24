class WelcomeController < ApplicationController
	def index
	end

	def about
	end

	def showmap
		@maps = Map.all
	end
end
