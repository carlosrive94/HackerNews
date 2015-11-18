class Submission < ActiveRecord::Base
    belongs_to :user
    acts_as_votable
    has_many :comments
    validates :title, presence: true
    
    validates :content, presence: true, if: "url.blank?"
    validates :url, presence: true, if: "content.blank?"
    validates :content, presence: false, if: "!url.blank?"
    validates :url, presence: false, if: "!content.blank?"
    
    after_initialize :set_default_values
    def set_default_values
        self.points ||= 0
    end
end
