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

  def create_report_mentions
    all_valid = true

    transaction do
      all_valid &= save

      report_ids = find_report_ids
      all_valid &= create_new_mentions(report_ids)

      raise ActiveRecord::Rollback unless all_valid
    end
    all_valid
  end

  def update_report_mentions(params)
    all_valid = true

    transaction do
      all_valid &= update(params)

      adding_repot_ids = find_adding_report_ids
      existing_report_ids = mentioning_reports.ids
      mentioned_report_ids = adding_repot_ids - existing_report_ids
      unmentioned_report_ids = existing_report_ids - adding_repot_ids

      all_valid &= create_new_mentions(mentioned_report_ids)
      records = mentioning_relations.where(mentioned_report_id: unmentioned_report_ids).destroy_all
      all_valid &= records.all?(&:destroyed?)

      raise ActiveRecord::Rollback unless all_valid
    end
    all_valid
  end

  private

  def find_adding_report_ids
    content.scan(%r{http://localhost:3000/reports/(\d+)}).flatten.map(&:to_i).uniq
  end

  def create_new_mentions(ids)
    ids.each do |report_id|
      mentioning_relations.new(mentioned_report_id: report_id).save
    end
  end
end
