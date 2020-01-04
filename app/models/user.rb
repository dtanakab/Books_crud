# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  has_many :books, dependent: :destroy
  has_many :reports, dependent: :destroy
  has_many :comments, dependent: :destroy

  has_many :active_follows, class_name: "Follow", foreign_key: "follower_id", dependent: :destroy
  has_many :passive_follows, class_name: "Follow", foreign_key: "followed_id", dependent: :destroy
  has_many :following, through: :active_follows, source: :followed
  has_many :followers, through: :passive_follows, source: :follower

  has_one_attached :image
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable
  validates :username, presence: true
  validate :file_validation, if: :image_attached?

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

  def follow(other_user)
    following << other_user
  end

  def unfollow(other_user)
    active_follows.find_by(followed_id: other_user.id).destroy
  end

  def following?(other_user)
    following.include?(other_user)
  end

  private
    def self.dummy_email(auth)
      "#{auth.uid}-#{auth.provider}@example.com"
    end

    def self.dummy_name(auth)
      "name:#{auth.uid}-#{auth.provider}"
    end

    def image_attached?
      image.attached?
    end

    def file_validation
      if image.blob.byte_size > 1_000_000
        file_raise_error
      elsif !image.blob.content_type.starts_with?("image/")
        file_raise_error
      end
    end

    def file_raise_error
      errors.add(:image)
    end
end
