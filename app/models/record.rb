class Record < ActiveRecord::Base
  attr_accessible :day, :expense, :income, :item, :remark, :tag
end
