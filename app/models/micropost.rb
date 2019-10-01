class Micropost < ApplicationRecord
  belongs_to :user
  has_many :likes, dependent: :destroy
  has_many :iine_users, through: :likes, source: :user
  default_scope -> { order(created_at: :desc) }
  mount_uploader :picture, PictureUploader
  validates :user_id, presence: true
  validates :content, presence: true, length: { maximum: 140 }
  validate  :picture_size

  def self.search(search)
    if search
      where(['content LIKE ?', "%#{search}%"])
    else
      all
    end
  end

  def iine(user)
    likes.create(user_id: user.id)
  end

  def iine?(user)
    iine_users.include?(user)
  end

  def uniine(user)
    likes.find_by(user_id: user.id).destroy
  end

  private

    def picture_size
      if picture.size > 5.megabytes
        errors.add(:picture, "※5MB以上の写真は投稿できません")
      end
    end
end
