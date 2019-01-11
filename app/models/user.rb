require 'digest/sha1'

class User < ApplicationRecord

# Associations
has_many :task_lists

# Validations
validates :login, presence: true, length: { maximum: 100 }
validates :crypted_password, presence: true, length: { maximum: 40 }
validates :salt, presence: true, length: { maximum: 40 }
validates :email, presence: true, length: { maximum: 100 }
validates :firstname, presence: true, length: { maximum: 100 }
validates :lastname, presence: true, length: { maximum: 100 }

# Functionality

# Authenticates a user by their login name and unencrypted password. Returns the user or nil.
def self.authenticate(login, password)
	u = find_by_login(login) # need to get the salt
	u && !u.deleted && u.active? && u.authenticated?(password) ? u : nil
end

# Encrypts some data with the salt.
def self.encrypt(password, salt)
	logger.debug "inside self.encrypt"
	logger.debug "self.encrypt#password: #{password}"
	logger.debug "self.encrypt#salt: #{salt}"
	logger.debug "hexdigest of #{"--#{salt}--#{password}--"}"
	Digest::SHA1.hexdigest("--#{salt}--#{password}--")
end

# Encrypts the password with the user salt
def encrypt(password)
	self.class.encrypt(password, salt)
end

def authenticated?(password)
	logger.debug "inside authenticated?"
	logger.debug "authenticated?:crypted_password: #{crypted_password}"
	logger.debug "authenticated?encrypt(password): #{encrypt(password)}"
	crypted_password == encrypt(password)
end

# protected

# before filter 
def encrypt_password(password)
	return if password.blank?
	self.salt = Digest::SHA1.hexdigest("--#{Time.now.to_s}--#{login}--") if new_record?
	self.crypted_password = encrypt(password)
end

end