class Post < ActiveRecord::Base

validates :title, presence: true
validates_length_of :content, minimum: 250
validates_length_of :summary, maximum: 250
validates :category, inclusion: { in: %w(Fiction Nonfiction) }
  validate :is_clickbait?

  CLICKBAIT = [
    /Won't Believe/i,
    /Secret/i,
    /Top [0-9]*/i,
    /Guess/i
  ]

  def is_clickbait?
    if CLICKBAIT.none? { |pattern| pattern.match title }
      errors.add(:title, "It's clickbait!")
    end
  end
end