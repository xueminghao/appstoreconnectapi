require 'json'
require 'fileutils'

module Asca
    class Configuration
        ROOTDIR = File.expand_path '~/.com.hurryup.asca'
        JSONFILE = File.expand_path 'config.json', ROOTDIR
        CACHE_DIR = File.expand_path 'cache', ROOTDIR
        class << self
            # reset config file
            def reset_config
                # remove all
                FileUtils.rm_rf(ROOTDIR)

                # create root dir
                Dir.mkdir ROOTDIR

                # create cache dir
                Dir.mkdir CACHE_DIR
                
                # init config file
                File.open(JSONFILE, 'w') { |file|
                    file.write("{}")
                }
            end

            # update config
            def update_config(key, value)
                if !File.exist?(JSONFILE)
                    reset_config
                end
                file_content = File.read(JSONFILE)
                configuration = JSON.parse(file_content)
                if value
                    configuration[key] = value
                else
                    configuration.delete(key)
                end
                File.open(JSONFILE, 'w') { |file| 
                    file.write(JSON.pretty_generate(configuration))
                }
                return 0
            end
            
            def get_config(key)
                if !File.exist?(JSONFILE)
                    reset_config
                end
                file_content = File.read(JSONFILE)
                configuration = JSON.parse(file_content)
                return configuration[key]
            end
        end
    end
end