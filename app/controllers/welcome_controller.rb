class WelcomeController < ApplicationController
	def index
		@maps = Map.all
	end

	def about
	end
end
