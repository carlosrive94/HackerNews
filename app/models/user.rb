class User < ActiveRecord::Base
    has_many :submissions
    has_many :comments
    has_many :replies
    after_initialize :set_default_values
    def set_default_values
        self.karma ||= 0
    end
    
    def self.find_or_create_from_auth_hash(auth_hash)
        user = where(uid: auth_hash.uid).first_or_create
        user.update(
            userName: auth_hash.info.name
        )
        user
    end
end
