# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable
  validates :username, presence: true

  def self.find_for_oauth(auth)
    user = User.where(uid: auth.uid, provider: auth.provider).first

    user ||= User.create(
      username: User.dummy_name(auth),
      uid: auth.uid,
      provider: auth.provider,
      email: User.dummy_email(auth),
      password: Devise.friendly_token[0, 20]
    )
    user.save
    user
  end

  private

  def self.dummy_email(auth)
    "#{auth.uid}-#{auth.provider}@example.com"
  end

  def self.dummy_name(auth)
    "name:#{auth.uid}-#{auth.provider}"
  end
end
