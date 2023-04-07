class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :items
  has_many :orders

  validates :nickname, presence: true
  validates :birthday, presence: true

  VALID_PASSWORD_REGEX = /\A(?=.*?[a-z])(?=.*?[\d])[a-z\d]+\z/i.freeze
  validates :password, format: {with: VALID_PASSWORD_REGEX, message: "は半角の英字と数字の両方を含めてください" }

  with_options presence: true do
    # ひらがな、カタカナ、漢字のみ許可する
    validates :first_name, format: {with: /\A[ぁ-んァ-ヶ一-龥々ー]+\z/, message: "は全角で入力してください"}
    validates :last_name, format: {with: /\A[ぁ-んァ-ヶ一-龥々ー]+\z/, message: "は全角で入力してください"}
    # カタカナのみ許可する
    validates :first_name_kana, format: {with: /\A[ァ-ヶー]+\z/, message: "は全角カナで入力してください"}
    validates :last_name_kana, format: {with: /\A[ァ-ヶー]+\z/, message: "は全角カナで入力してください"}
  end

end
