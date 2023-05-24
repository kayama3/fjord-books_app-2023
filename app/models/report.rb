# frozen_string_literal: true

class Report < ApplicationRecord
  belongs_to :user
  has_many :comments, as: :commentable, dependent: :destroy

  validates :title, presence: true
  validates :content, presence: true

  def editable?(target_user)
    user == target_user
  end

  def created_on
    created_at.to_date
  end

  has_many :mentioning_relations, class_name: 'Mention', foreign_key: :mentioning_report_id, dependent: :destroy, inverse_of: :mentioning_report
  has_many :mentioning_reports, through: :mentioning_relations, source: :mentioned_report, dependent: :destroy

  has_many :mentioned_relations, class_name: 'Mention', foreign_key: :mentioned_report_id, dependent: :destroy, inverse_of: :mentioned_report
  has_many :mentioned_reports, through: :mentioned_relations, source: :mentioning_report, dependent: :destroy

  def find_report_ids
    content.scan(%r{http://localhost:3000/reports/(\d+)}).flatten.map(&:to_i).uniq
  end

  def create_new_mentions(ids)
    ids.map do |report_id|
      mentioning_relations.new(mentioned_report_id: report_id)
    end
  end

  def create_report_mentions
    return unless save!

    report_ids = find_report_ids

    transaction do
      new_mentions = create_new_mentions(report_ids)
      new_mentions.each(&:save!)
    end
  end

  def update_report_mentions(params)
    return unless update!(params)

    report_ids = find_report_ids
    mentioned_report_ids = report_ids - mentioning_reports.map(&:id)
    unmentioned_reports = mentioning_reports.map(&:id) - report_ids

    transaction do
      new_mentions = create_new_mentions(mentioned_report_ids)
      new_mentions.each(&:save!)
      mentioning_relations.where(mentioned_report_id: unmentioned_reports).map(&:destroy!)
    end
  end
end
