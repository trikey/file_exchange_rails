class User < ActiveRecord::Base
  
  validates :fio, presence: true, length: { in: 3..20 }
  validates :password, confirmation: true, length: { in: 6..20 }, presence: true, if: -> { password.present? }
  #validates_length_of :password, in: 6..20
	validates :email, presence: true, uniqueness: true, email_format: { message: "doesn't look like an email address" }


	before_save :encrypt_password
	after_save :clear_password

	def has_password?
		password.present?
	end

	def encrypt_password
		if password.present?
	    self.salt = BCrypt::Engine.generate_salt
	    self.password = BCrypt::Engine.hash_secret(password, salt)
	    self.password_confirmation = BCrypt::Engine.hash_secret(password, salt)
	  end
	end
	def clear_password
		self.password = nil
	end


	def self.find_all_by_name(q)
		self.where('email LIKE ? or fio LIKE ? or organisation LIKE ?', "%#{q}%", "%#{q}%", "%#{q}%")
	end


end