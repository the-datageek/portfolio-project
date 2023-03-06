class Project < ActiveRecord::Base
    # active one to many association
    belongs_to :user

    #restricting our integer valuese to be only betwween the specified Enum values
    #our enums start from 0 to 3, 0 represnts CREATED and so on...
    
    enum :status, [ :CREATED, :ONGOING, :COMPLETED, :CANCELLED ]
end