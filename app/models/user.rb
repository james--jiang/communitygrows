class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :timeoutable, :timeout_in => 30.minutes
  def initalize(attributes=nil)
    attr_with_defaults = {:admin => false}.merge(attributes)
    super(attr_with_defaults)
  end


end