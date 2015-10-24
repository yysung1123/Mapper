class Map < ActiveRecord::Base
  has_many :data, :dependent => :destroy
end
