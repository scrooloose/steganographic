class Image < ActiveRecord::Base
  has_attached_file :image,
                    :styles => { :default => "100x100" },
                    :path => ":rails_root/public/system/:class/:id/:style/:filename",
                    :url => "/system/:class/:id/:style/:filename"
end
