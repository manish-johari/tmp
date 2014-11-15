class Myinterest < ActiveRecord::Base
  belongs_to :selectable
  belongs_to :user
end
