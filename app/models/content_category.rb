class ContentCategory < ApplicationRecord
  include YearlyModel
  has_many :contents, dependent: :destroy
  validates :name, :presence => true, :length => { maximum: 50 }

  def contents_chronological
    @content_category.contents.order('created_at desc')
  end
end
