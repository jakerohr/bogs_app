class TagsTwins < ActiveRecord::Base
  belongs_to :twin
  belongs_to :tag
end
