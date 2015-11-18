class Comment < ActiveRecord::Base
    belongs_to :user
    acts_as_votable
    belongs_to :submission
    has_many :replies
    validates :content, presence: true
    after_initialize :set_default_values
    def set_default_values
        self.points ||= 0
    end
end
