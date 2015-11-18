class Reply < ActiveRecord::Base
    belongs_to :user
    acts_as_votable
    belongs_to :comment
    after_initialize :set_default_values
    def set_default_values
        self.points ||= 0
    end
end
