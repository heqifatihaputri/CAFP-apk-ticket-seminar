class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :balances, dependent: :destroy

  has_one  :user_profile, dependent: :destroy
  has_one  :cart, dependent: :destroy

  has_many :order_temps, dependent: :destroy
  has_many :orders, dependent: :destroy
  has_many :my_tickets, class_name: "Ticket", foreign_key: "ownership_id"
  has_many :ticket_sessions, dependent: :destroy

  attr_accessor :skip_generate_default_password

  accepts_nested_attributes_for :user_profile, allow_destroy: true
  accepts_nested_attributes_for :balances, allow_destroy: true

  before_save :generate_user_uid

  after_create :create_first_balance, :create_cart

  scope :order_by_name, -> { joins(:user_profile).order("user_profiles.full_name").references(:user_profile) }
  scope :order_by_created_at, -> { order(created_at: :desc) }
  scope :registered_by_year,  -> (year) { where("extract(year from created_at) = ?", year) }
  scope :order_by_user_uid,   -> { joins(:user_profile).order("user_profiles.user_uid DESC").references(:user_profile) }

  def generate_user_uid
    profile = user_profile
    if profile.user_uid.blank?
      profile.user_uid = 33400001
      if UserProfile.where(user_uid: 33400001).present?
        last_profile  = UserProfile.order(:user_uid).last
        profile.user_uid = (last_profile.user_uid.to_i + 1).to_s
      end
    end
  end

  def generate_default_password
    return if skip_generate_default_password

    rand_password = Date.today.to_s.gsub("-", "") + SecureRandom.hex(5)
    self.password              = rand_password
    self.password_confirmation = rand_password
    self.default_password      = rand_password
  end

  # BALANCE METHODS===
  def create_first_balance
    balances.create(period: Date.today.beginning_of_month)
  end

  def current_balance
    balances.last
  end
  # END===

  def create_cart
    build_cart.save
  end

  def self.registered_increase(now, before)
    return "0%" if (now < before) || before.eql?(0)

    "#{(before / now) * 100}%"
  end
end
