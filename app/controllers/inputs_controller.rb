require 'json'
require 'csv'

class InputsController < ApplicationController
  def create
    begin
      @input = Input.new(input_params)
      @input.save
      file = File.read('/public/tag/' + @input.searchtext)
      tag_hash = JSON.parse(file)
      @map = Map.new
      @map.title = @input.searchtext
      tag_hash['result'].each do |dataset|
        file = File.read('/public/dataset/' + dataset)
        dataset_hash = JSON.parse(file)
        dataset_hash['result']['distribution'].each do |d|
          e = d['HB_URL'].partition('TODC')[2]
          a = CSV.read('/public' + e)
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
        end
      end
      @map.save
    rescue
    end
    redirect_to showmap_path
  end

  private
    def input_params
      params.require(:input).permit(:searchtext)
    end
end
