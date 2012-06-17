class Image < ActiveRecord::Base
  validates :name, :presence => true
  validates_attachment_presence :image

  has_attached_file :image,
                    :styles => { :default => "200x200", :home_page => "150x150", :large => "480x480", :new_challenge_form => "80x80" },
                    :path => ":rails_root/public/system/:class/:id/:style/:filename",
                    :url => "/system/:class/:id/:style/:filename"
end
