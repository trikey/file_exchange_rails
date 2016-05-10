class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

	# validates :fio, presence: true, length: { in: 3..20 }
	# validates :organisation, presence: true

	def self.find_all_by_name(q)
		self.where('email LIKE ? or fio LIKE ? or organisation LIKE ?', "%#{q}%", "%#{q}%", "%#{q}%")
	end

	def password_required?
		
	end
end
