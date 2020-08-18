require 'curb'
require 'json'
require "base64"

module Asca
  class Profiles
    class << self
      def download_profile(profile_name, out_put_dir = nil)
        if !out_put_dir
          out_put_dir = Asca::Configuration.get_config('out_put_dir')
          if !out_put_dir
              puts "Please enter your out put dir:"
              out_put_dir = File.expand_path(gets.chomp)
              Asca::Configuration.update_config('out_put_dir', out_put_dir)
          end
        end
        http = Curl.get(URI_PROFILES, { 'filter[name]' => profile_name}) do |http|
          http.headers['Authorization'] = ' Bearer ' + Asca::Token.new_token
        end
        profile_obj = JSON.parse(http.body_str)
        profile_content = profile_obj["data"][0]["attributes"]['profileContent']
        File.open(File.expand_path(profile_name + ".mobileprovision", out_put_dir), 'w') do |file|
          file.write(Base64.decode64(profile_content))
        end
      end

      def install_profile(profile_name)
        download_profile profile_name, Asca::Configuration::CACHE_DIR
        profile_file_path = File.expand_path(profile_name + ".mobileprovision", Asca::Configuration::CACHE_DIR)

        # install profile
        `open #{profile_file_path}`
      end
    end
  end
end