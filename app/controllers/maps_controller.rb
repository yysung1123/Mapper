require 'CSV'

class MapsController < ApplicationController
  def new
    @map = Map.new
  end
  def create
    @map = Map.new(map_params)
    a = CSV.read('public/' + @map.attachment.url)
    i = 0
    j = 0
    flag = 0
    a[0].each do |f|
      ["Addr", "地址"].each do |str|
        if f.include? str
          flag = 1
          break
        end
      end
      if flag == 1
        break
      end
      i += 1
    end
    a.each do |f|
      result = Geocoder.search(f[i])
      if not result.empty?
        location = result[0].instance_variable_get(:@data)['geometry']['location']
        label_now = ""
        a[0].count.times do |cnt|
          if cnt != i
            label_now += f[cnt]
            label_now += ' '
          end
        end
        @map.data.build(:lat => location['lat'], :lng => location['lng'], :label => label_now)
      end
      j += 1
      if j == 80
        break
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
