class Map < ActiveRecord::Base
  has_many :data, :dependent => :destroy
  mount_uploader :attachment, AttachmentUploader # Tells rails to use this uploader for this model.
  validates :title, presence: true # Make sure the owner's name is present.
end
