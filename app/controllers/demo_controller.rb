require 'CSV'
class DemoController < ApplicationController
    def index
    end
    def new
    @map = Map.new
    a = CSV.read('public/wheee.csv')
    i = 0
    a.each do |d|
      #d[1] = d[1].split('(')[0]
      result = Geocoder.search(d[1])
      if not result.empty?
        location = result[0].instance_variable_get(:@data)['geometry']['location']
        @map.data.build(:lat => location['lat'], :lng => location['lng'], :label => d[3])
      end
      i += 1
      if i == 80
        break
      end
    end
    @map.save
  end
end
