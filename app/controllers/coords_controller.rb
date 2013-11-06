require 'open-uri'
require 'json'

class CoordsController < ApplicationController
  def fetch_weather
    
    if params[:address] != nil && params[:address] != "" 
        @address = params[:address]
        @url_safe_address = URI.encode(@address)
    else
        @address = "Northwestern University"
        @url_safe_address = URI.encode(@address)
    end

    url = "http://maps.googleapis.com/maps/api/geocode/json?address="+ @url_safe_address + "&sensor=true"

    raw_data = open(url).read
    parsed_data = JSON.parse(raw_data)
    @latitude = parsed_data["results"][0]["geometry"]["location"]["lat"]
    @longitude = parsed_data["results"][0]["geometry"]["location"]["lng"]

    your_api_key = "ac42a7e5f4878e4b42c0a4a8157794bc"

    url = "https://api.forecast.io/forecast/" + your_api_key + "/" + @latitude.to_s + "," + @longitude.to_s

    raw_data = open(url).read
    parsed_data = JSON.parse(raw_data)

    @temperature = parsed_data["currently"]["temperature"]
    @minutely_summary = parsed_data["minutely"]["summary"]
    @hourly_summary = parsed_data["hourly"]["summary"]
    @daily_summary = parsed_data["daily"]["summary"]
  end
end
