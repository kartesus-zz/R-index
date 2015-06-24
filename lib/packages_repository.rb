require 'fileutils'
require 'securerandom'

require 'sqlite3'

class PackagesRepository
  def initialize(dbname)
    FileUtils.mkdir_p File.expand_path('../data', File.dirname(__FILE__))
    @db = SQLite3::Database.new File.expand_path("../data/#{dbname}.db", File.dirname(__FILE__))
    @db.results_as_hash = true
    @db.execute "create table if not exists packages (name VARCHAR(150))"
    @db.execute "create table if not exists package_versions (package_name VARCHAR(150), version VARCHAR(10))"
  end

  def << packages
    packages.each do |package|
      name = package["Package"]
      @db.execute "insert into packages values (?)", [name]
      @db.execute "insert into package_versions values (?,?)", [name, package["Version"]]
    end
  end

  def all
    sql = <<-SQL
      select p.name, v.version as latest_version
      from packages as p
      left join package_versions as v on v.package_name = p.name
    SQL
    @db.execute(sql).map {|r| {"name" => r["name"], "latest_version" => r["latest_version"]} }
  end
end
