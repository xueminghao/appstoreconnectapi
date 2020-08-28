require 'http'
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
        response = HTTP.auth('Bearer ' + Asca::Token.new_token).get(URI_PROFILES, :params => { 'filter[name]' => profile_name })
        if response.status.success?
          profile_obj = JSON.parse(response.body)
          profile_content = profile_obj["data"][0]["attributes"]['profileContent']
          File.open(File.expand_path(profile_name + ".mobileprovision", out_put_dir), 'w') do |file|
            file.write(Base64.decode64(profile_content))
          end
        else
          Log.error(response.body)
        end
      end

      def install_profile(profile_name)
        download_profile profile_name, Asca::Configuration::CACHE_DIR
        profile_file_path = File.expand_path(profile_name + ".mobileprovision", Asca::Configuration::CACHE_DIR)

        # install profile
        `open #{profile_file_path}`
      end

      # notion: bundle_id is not bundle identifier and device id is udid。They are the corresponding api id.
      def create_new_profile(options = {})
        if !options[:name]
          Asca::Log.error('No profile name specified')
          return false
        end
        if !options[:type]
          Asca::Log.error('No type specified')
          return false
        end
        if !options[:bundle_id]
          Asca::Log.error('No bundle id specfied')
          return false
        end
        if !options[:certificate_ids] || options[:certificate_ids].length == 0
          Asca::Log.error('No certificate id specified')
          return false
        end

        response = HTTP.auth('Bearer ' + Asca::Token.new_token).post(URI_PROFILES, :json => { "data" => {
          "type" => "profiles",
          "attributes" => {
              "name" => options[:name],
              "profileType" => options[:type],
          },
          "relationships" => {
            "bundleId" => {
              "data" => {
                "type" => "bundleIds",
                "id" => options[:bundle_id],
              }
            },
            "certificates" => {
              "data" => options[:certificate_ids].map { |certificate_id| { "type" => "certificates", "id" => certificate_id }}
            },
            "devices" => {
              "data" => options[:device_ids] ? options[:device_ids].map { |device_id| { "type" => "devices", "id" => device_id } } : nil
            },
          }
        }})
        if response.status.success?
            return true
        else
            puts response.body
            return false
        end      
      end

      def delete_profile(options = {})
        # query profile id
        response = HTTP.auth('Bearer ' + Asca::Token.new_token).get(URI_PROFILES, :params => { 'filter[name]' => options[:name] })
        if response.status.success?
          responseObj = JSON.parse(response.body)
          queried_profile_list = responseObj["data"]
          if queried_profile_list.length() > 0
            profile_id = queried_profile_list[0]["id"]
          end
        else
          Log.error(response.body)
          return
        end
        if !profile_id
          puts "No profile named #{options[:name]} found!"
          return
        end

        # delete profile
        response = HTTP.auth('Bearer ' + Asca::Token.new_token).delete(URI_PROFILES + "/#{profile_id}")
        if response.status.success?
          Log.info("Profile named #{options[:name]} deleted successfully!")
        else
          puts response.body
        end
        return response.status.success?
      end

      # update profile. The new profile is almost the same as the old one, such as the same name, bundle id, certificate ids, with only exception that the new one always try to include all the currently reigstered devices.
      def update_profile(options = {}) 
        # query profile info
        response = HTTP.auth('Bearer ' + Asca::Token.new_token).get(URI_PROFILES, :params => { 'filter[name]' => options[:name] })
        if response.status.success?
          responseObj = JSON.parse(response.body)
          queried_profile_list = responseObj["data"]
          if queried_profile_list.length() > 0
            profile = queried_profile_list[0]
          end
        else
          Log.error(response.body)
          return
        end

        # create new profile
        profile_type = profile["attributes"]["profileType"]

        # get bundle id
        response = HTTP.auth('Bearer ' + Asca::Token.new_token).get(profile["relationships"]["bundleId"]["links"]["self"])
        bundle_id = JSON.parse(response.body)["data"]["id"]
        response = HTTP.auth('Bearer ' + Asca::Token.new_token).get(profile["relationships"]["certificates"]["links"]["self"])
        certificate_ids = JSON.parse(response.body)["data"].map { |cer| cer["id"] }

        device_ids = Asca::Devices.list_devices.map { |device|
          device["id"]
        }

        # delete old prifile
        delete_profile :name => options[:name]
        
        create_new_profile :name => options[:name], :type => profile_type, :bundle_id => bundle_id, :device_ids => device_ids, :certificate_ids => certificate_ids
        return true
      end
    end
  end
end