module ApplicationHelper
  def default_meta_tags
    {
      site: "Pensieve",
      image: image_url('https://res.cloudinary.com/dvtzwb5ue/image/upload/f_auto,q_auto/k2slzpdzzqgz7ihfsppi'),
      description: "A simple yet powerful app to preserve your memories",
      og: {
        title: "Pensieve",
        image: image_url('https://res.cloudinary.com/dvtzwb5ue/image/upload/f_auto,q_auto/k2slzpdzzqgz7ihfsppi'),
        description: "A simple yet powerful app to preserve your memories",
        site_name: "Pensieve"
      }
      # TODO: add twitter tags
    }
  end

  def date_to_days_since_epoch(date)
    date.to_time.to_i / 60 / 60 / 24
  end
  
  def days_since_epoch_to_date(days)
    Time.at(days * 24 * 60 * 60).to_date
  end
end
