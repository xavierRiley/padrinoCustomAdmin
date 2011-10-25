class AdminConfiguration < ActiveRecord::Base
    serialize :contains
    serialize :validation

end
