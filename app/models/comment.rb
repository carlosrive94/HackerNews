class Comment < ActiveRecord::Base
    belongs_to :user
    belongs_to :submission
    has_many :replies
    after_initialize :set_default_values
    def set_default_values
        self.points ||= 0
    end
end
