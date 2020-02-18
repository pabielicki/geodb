# lib/geolocation_api.rb

module GeolocationApi
  VERSION='0.0.1'
  require 'net/http'

  class << self
    BASE_URL = "http://api.ipstack.com/" 
    IPSTACK_KEY = ENV.fetch("IPSTACK_API_KEY")
    def get_geolocation(ip)
      url = URI.parse(BASE_URL + ip + "?access_key=" + IPSTACK_KEY)
      http = Net::HTTP.new(url.host, url.port)
      req = Net::HTTP::Get.new(url.to_s)
      resp = http.request(req).body
      parsed = JSON.parse(resp)
      parsed["ip_type"] = parsed.delete("type")
      parsed.select { |k, _| permitted_keys.include?(k) }
    end

    private
    def permitted_keys
      ["ip", "continent_code", "continent_name", "country_code",
       "country_name", "region_code", "region_name", "city",
       "zip", "latitude", "longitude", "ip_type"]
    end

  end
end
