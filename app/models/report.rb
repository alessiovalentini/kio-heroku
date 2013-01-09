class Report < ActiveRecord::Base
  attr_accessible :abuseType, :address, :block, :description, :email, :groundId, :lat, :lng, :name, :otherGroundDescription, :otherGroundName, :phone, :recordId, :reportDate, :row, :seat
end
