class Skill < ActiveRecord::Base
    #a one to many association
    belongs_to :user
end