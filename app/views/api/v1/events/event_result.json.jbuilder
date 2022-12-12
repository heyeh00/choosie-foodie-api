json.event do
  json.extract! @event, :id, :datetime, :user_id, :closed
  json.date @event.datetime.strftime("%F")
  json.time @event.datetime.strftime("%H:%M")
end

json.restaurant do
  json.extract! @restaurant, :id, :name, :address, :cuisine, :phone_number, :image_url, :ave_price, :rating
end

json.attendees @attendees do |attendee|
  json.extract! attendee, :id, :name, :image_url
end
