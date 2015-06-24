require 'dcf'

class Manifest
  def initialize(packages)
    @packages = Dcf.parse(packages)
  end

  def take(n)
    @packages.take(n)
  end
end
