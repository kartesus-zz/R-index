require 'fileutils'
require 'securerandom'

require 'sqlite3'

class PackagesRepository
  def initialize(dbname)
    FileUtils.mkdir_p File.expand_path('../data', File.dirname(__FILE__))
    @db = SQLite3::Database.new File.expand_path("../data/#{dbname}.db", File.dirname(__FILE__))
    @db.results_as_hash = true
    @db.execute "create table if not exists packages (id VARCHAR(8), name VARCHAR(150))"
    @db.execute "create table if not exists package_versions (package_id VARCHAR(8), version VARCHAR(10))"
  end

  def << packages
    packages.each do |package|
      id = SecureRandom.hex(8)
      @db.execute "insert into packages values (?,?)", [id, package["Package"]]
      @db.execute "insert into package_versions values (?,?)", [id, package["Version"]]
    end
  end

  def all
    sql = <<-SQL
      select p.name, v.version as latest_version
      from packages as p
      left join package_versions as v on v.package_id = p.id
    SQL
    @db.execute(sql).map {|r| {"name" => r["name"], "latest_version" => r["latest_version"]} }
  end
end
