module ApplicationHelper
  def date_to_days_since_epoch(date)
    date.to_time.to_i / 60 / 60 / 24
  end
  
  def days_since_epoch_to_date(days)
    Time.at(days * 24 * 60 * 60).to_date
  end
end
