require 'CSV'

class MapsController < ApplicationController
  def new
    @map = Map.new
  end
  def create
    @map = Map.new(map_params)
    a = CSV.read('public/' + @map.attachment.url)
    a.each do |d|
      result = Geocoder.search(d[0])
      if not result.empty?
        location = result[0].instance_variable_get(:@data)['geometry']['location']
        @map.data.build(:lat => location['lat'], :lng => location['lng'], :label => d[1])
      end
    end
    @map.save
    redirect_to :showmap
  end

  private
    def map_params
      params.require(:map).permit(:title, :attachment)
    end
end
