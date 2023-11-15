# == Schema Information
#
# Table name: addresses
#
#  id                   :bigint           not null, primary key
#  address              :string
#  country              :string
#  country_code_alpha_3 :string
#  full_address         :string
#  lat                  :string
#  lng                  :string
#  name                 :string
#  place_formatted      :string
#  postcode             :string
#  region               :string
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#
class Address < ApplicationRecord
end