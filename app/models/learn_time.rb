class LearnTime < ActiveRecord::Base

  belongs_to :user
  belongs_to :link

  def self.report_of_learn_time(user_id, date)
    LearnTime.where("user_id = ? and created_at >= ?", user_id, date ).group('date(created_at)').count
  end
end
