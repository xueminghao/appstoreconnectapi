require 'curb'

module Asca
  class Profiles
    class << self
      def download_profile(profile_name)
        http = Curl.get(URI_PROFILES) do |http|
          http.headers['Authorization'] = ' Bearer ' + Asca::Token.new_token
        end
      end
    end
  end
end