class User < ApplicationRecord
  rolify
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :projects, dependent: :destroy
  has_many :comments, dependent: :destroy

  validates :name, presence: true, on: :update

  def display_name
    name.presence || email
  end
end
