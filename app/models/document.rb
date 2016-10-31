class Document < ActiveRecord::Base
    has_many :read_sessions
    has_many :users, through: :read_sessions
end
