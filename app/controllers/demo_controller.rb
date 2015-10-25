require 'CSV'
class DemoController < ApplicationController
    def index
    end

    def new
    @map = Map.new
    @map.title = "台灣犯罪事件發生地圖"
    a = CSV.read('public/wheee.csv')
    i = 0
    j = 0
    a[0].each do |f|
      if ['Address', '地址'].include?(f)
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
  end
end
