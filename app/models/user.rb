class User < ActiveRecord::Base
    has_many :submissions
    has_many :comments
    has_many :replies
    after_initialize :set_default_values
    def set_default_values
        self.karma ||= 0
    end
end
