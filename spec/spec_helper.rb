require 'fileutils'
FileUtils.rm_rf File.expand_path('../data', File.dirname(__FILE__))

RSpec.configure do |config|
  config.order = :random
  Kernel.srand config.seed
end
