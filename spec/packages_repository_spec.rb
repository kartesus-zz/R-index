require 'securerandom'
require 'packages_repository'

RSpec.describe PackagesRepository do
  describe "#<<" do
    before :each do
      @repo = PackagesRepository.new(SecureRandom.hex(4))
    end

    it "stores package" do
      package = {"Package" => "foo", "Version" => "1.0.0"}
      @repo << [package]
      expect(@repo.all).to eq([{"name" => "foo", "latest_version" => "1.0.0"}])
    end

    it "doesn't store package twice" do
      package = {"Package" => "foo", "Version" => "1.0.0"}

      @repo << [package]
      @repo << [package]

      expect(@repo.all).to eq([{"name" => "foo", "latest_version" => "1.0.0"}])
    end

    it "stores latest_version of the same package" do
      package1 = {"Package" => "foo", "Version" => "1.0.0"}
      package2 = {"Package" => "foo", "Version" => "1.1.0"}

      @repo << [package1]
      @repo << [package2]

      expect(@repo.all).to eq([{"name" => "foo", "latest_version" => "1.1.0"}])
    end
  end

end
