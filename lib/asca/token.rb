require 'json'

module Asca
    class Token
        ROOTDIR = File.expand_path '~/.com.hurryup.asca'
        JSONFILE = File.expand_path 'config.json', ROOTDIR
        class << self
            # init config file
            def init_config
                # create root dir under home directory
                if !File.exist?(ROOTDIR)
                    Dir.mkdir ROOTDIR
                end
                
                if !File.exist?(JSONFILE)
                    File.open(JSONFILE, 'w') { |file|
                        file.write("{}")
                    }
                end
            end

            # update config
            def update_config(key, value)
                if !File.exist?(JSONFILE)
                    puts 'Error: config file does not exist!'
                    return -1
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
        end
    end
end