require 'manifest'

RSpec.describe Manifest do
  let(:packages) do
    "Package: A3
Version: 0.9.2
Depends: R (>= 2.15.0), xtable, pbapply
Suggests: randomForest, e1071
License: GPL (>= 2)
NeedsCompilation: no

Package: abbyyR
Version: 0.1
Depends: R (>= 3.2.0)
Imports: httr, XML
License: GPL (>= 2)
NeedsCompilation: no"
  end

  describe "#take" do
    it "returns an arbitrary number of packages" do
      manifest = Manifest.new(packages)
      a3 = manifest.take(1).first
      expect(a3["Package"]).to eq('A3')
      expect(a3["Version"]).to eq('0.9.2')
    end
  end
end
