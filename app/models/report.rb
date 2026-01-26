# frozen_string_literal: true

class Report < ApplicationRecord
  belongs_to :user
  has_many :comments, as: :commentable, dependent: :destroy

  has_many :active_mentions, class_name: 'Mention',
                             foreign_key: 'mentioning_report_id',
                             dependent: :destroy,
                             inverse_of: :mentioning_report

  has_many :mentioning_reports, through: :active_mentions, source: :mentioned_report

  has_many :passive_mentions, class_name: 'Mention',
                              foreign_key: 'mentioned_report_id',
                              dependent: :destroy,
                              inverse_of: :mentioned_report

  has_many :mentioned_reports, through: :passive_mentions, source: :mentioning_report

  validates :title, presence: true
  validates :content, presence: true

  after_save :save_mentions

  def editable?(target_user)
    user == target_user
  end

  def created_on
    created_at.to_date
  end

  private

  def save_mentions
    found_ids = content.scan(%r{http://localhost:3000/reports/(\d+)}).flatten.uniq
    report_ids = Report.where(id: found_ids).where.not(id: id).pluck(:id)
    self.mentioning_report_ids = report_ids
  end
end
