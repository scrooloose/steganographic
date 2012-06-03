class Image < ActiveRecord::Base
  has_attached_file :image,
                    :styles => { :default => "200x200", :home_page => "150x150" },
                    :path => ":rails_root/public/system/:class/:id/:style/:filename",
                    :url => "/system/:class/:id/:style/:filename"
end
