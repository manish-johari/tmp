class Religion < ActiveRecord::Base
  has_many :myinterests, as: :selectable  
end
