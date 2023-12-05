module Ransackable
  extend ActiveSupport::Concern

  class_methods do
    def ransackable_attributes(auth_object = nil)
      if self.name == 'Memory'
        [ "description", 
        "title", 
        "place", 
        "country", 
        "location", 
        "date",
        "email" ]
      elsif self.name == 'User'
        [ "email" ]
      else
        []
      end
    end

    def ransackable_associations(auth_object = nil)
      if self.name == "Memory"
        [ "author" ]
      else
        []
      end
    end
  end
end
