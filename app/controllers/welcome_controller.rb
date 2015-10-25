class WelcomeController < ApplicationController
	def index
    @input = Input.new
	end

	def about
	end

	def showmap
		@maps = Map.all
	end

  def create
    begin
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
        end
      end
      @map.save
    rescue
  end
end
