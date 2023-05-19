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

  def mentioning_report_ids
    content.scan(%r{http://localhost:3000/reports/(\d+)}).flatten.map(&:to_i)
  end

  def create_report_mentions
    save

    mentioning_report_ids.each do |report_id|
      mentioning_relations.create(mentioned_report_id: report_id)
    end
  end

  def update_report_mentions(params)
    update(params)

    mentioning_report_ids.each do |report_id|
      mentioning_relations.create(mentioned_report_id: report_id)
    end

    unmentioned_report_ids = mentioning_reports.map(&:id) - mentioning_report_ids
    mentioning_relations.where(mentioned_report_id: unmentioned_report_ids).map(&:destroy)
  end
end
