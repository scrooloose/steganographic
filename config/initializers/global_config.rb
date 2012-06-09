config_file = Rails.root.join('config', 'global_config.yml')
unless File.exists?(config_file)
  raise "Expected global config file to exist: #{config_file}"
end

GlobalConfig = HashWithIndifferentAccess.new(YAML.load_file(config_file))
