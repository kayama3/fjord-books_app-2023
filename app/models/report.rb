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

  has_many :mentioning_relations, class_name: 'Mention', foreign_key: :mentioning_report_id
  has_many :mentioning_reports, through: :mentioning_relations, source: :mentioned_report, dependent: :destroy

  has_many :mentioned_relations, class_name: 'Mention', foreign_key: :mentioned_report_id
  has_many :mentioned_reports, through: :mentioned_relations, source: :mentioning_report, dependent: :destroy
end
