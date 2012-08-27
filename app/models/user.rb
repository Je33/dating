class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :phone, :password, :password_confirmation,
                  :remember_me, :name, :age, :sex, :search_sex,
                  :search_age_from, :search_age_to, :subscription
  # attr_accessible :title, :body

  validates :phone, :presence => true, :uniqueness => true, :format => /^\+79\d{2}\d{3}\d{4}$/i

  def email_required?
    false
  end
end
