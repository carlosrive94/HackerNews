class Submission < ActiveRecord::Base
    belongs_to :user
    acts_as_votable
    has_many :comments
    after_initialize :set_default_values
    def set_default_values
        self.points ||= 0
    end

end
