class Book < ApplicationRecord
  belongs_to :user
  has_many :book_comments, dependent: :destroy
  has_many :favorites, dependent: :destroy

  # いいねの多い順に表示
  # ラムダ｛｝の中に条件を提示
    # create_atカラムが1.week.ago.beginning_of_day（一週間前）からTime.current.end_of_day（今日）までに該当するものを指定
  has_many :week_favorites, -> { where(created_at: 1.week.ago.beginning_of_day..Time.current.end_of_day) }

  # 閲覧数
  has_many :view_counts, dependent: :destroy

  # 本の投稿数
  scope :created_today, -> {where(created_at: Time.current.all_day)}
  scope :created_yesterday, -> {where(created_at: 1.day.ago.all_day)}
  scope :created_this_week, -> {where(created_at: (Time.current - 6.day).beginning_of_day..Time.current.end_of_day)}
  scope :created_last_week, -> {where(created_at: (Time.current - 13.day).beginning_of_day..(Time.current - 7.day).end_of_day)}

  validates :title, presence: true
  validates :body, presence: true

  validates :body,
    length: { maximum: 200 }

  def favorited_by?(user)
    favorites.exists?(user_id: user.id)
  end

  def self.looks(search, word)
    if search == "perfect_match"
      @book = Book.where("title LIKE?", "#{word}")
    elsif search == "forward_match"
      @book = Book.where("title LIKE?", "#{word}%")
    elsif search == "backward_match"
      @book = Book.where("title LIKE?", "%#{word}")
    elsif search == "partial_match"
      @book = Book.where("title LIKE?", "%#{word}%")
    else
      @book = Book.all
    end
  end
end
