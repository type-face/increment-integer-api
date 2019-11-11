# frozen_string_literal: true

class User < ActiveRecord::Base
  extend Devise::Models
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable
  include DeviseTokenAuth::Concerns::User

  validates :incrementer, numericality: { greater_than_or_equal_to: 0 }
end
