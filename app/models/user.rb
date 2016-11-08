class User < ActiveRecord::Base
  
  has_many :read_sessions
  has_many :documents, through: :read_sessions
  
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :timeoutable, :timeout_in => 30.minutes
  def initalize(attributes=nil)
    attr_with_defaults = {:admin => false}.merge(attributes)
    super(attr_with_defaults)
  end
  
  def has_read?(doc)
    return (self.documents.include?(doc))
  end

end