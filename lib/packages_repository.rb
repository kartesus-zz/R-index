require 'fileutils'
require 'securerandom'

require 'sqlite3'
require 'dcf'

class PackagesRepository
  def initialize(dbname)
    FileUtils.mkdir_p File.expand_path('../data', File.dirname(__FILE__))
    @db = SQLite3::Database.new File.expand_path("../data/#{dbname}.db", File.dirname(__FILE__))
    @db.results_as_hash = true
    @db.execute "create table if not exists packages (id VARCHAR(8), name VARCHAR(150))"
  end

  def << packages
    packages = Dcf.parse(packages)
    packages.each do |package|
      @db.execute "insert into packages values (?,?)", [SecureRandom.hex(8), package["Package"]]
    end
  end

  def all
    @db.execute("select name from packages").map {|r| {"name" => r["name"]} }
  end
end
