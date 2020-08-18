require 'curb'
require 'json'
require "base64"

module Asca
  class Profiles
    class << self
      def download_profile(profile_name, out_put_dir)
        http = Curl.get(URI_PROFILES, { 'filter[name]' => profile_name}) do |http|
          http.headers['Authorization'] = ' Bearer ' + Asca::Token.new_token
        end
        profile_obj = JSON.parse(http.body_str)
        profile_content = profile_obj["data"][0]["attributes"]['profileContent']
        File.open(File.expand_path(profile_name + ".mobileprovision", out_put_dir), 'w') do |file|
          file.write(Base64.decode64(profile_content))
        end
      end
    end
  end
end