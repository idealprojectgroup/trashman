require 'singleton'
require 'garbage_man/manager'

class MockFogFile < Struct.new(:key)
  def destroy
    true
  end
end

class MockFogContainer
  include Singleton

  def files
    @files ||= [
      MockFogFile.new("backup.2015-01-01T10-00-01.tar.gz"),
      MockFogFile.new("backup.2015-01-02T10-00-01.tar.gz"),
      MockFogFile.new("backup.2015-01-03T10-00-01.tar.gz"),
      MockFogFile.new("backup.2015-01-04T10-00-01.tar.gz"),
      MockFogFile.new("backup.2015-01-05T10-00-01.tar.gz"),
    ]
  end
end

class MockFogDirectories
  def get(container)
    MockFogContainer.instance
  end
end

class MockFogConnection
  def directories
    MockFogDirectories.new
  end
end

describe GarbageMan::Manager do
  describe "#cleanup!" do
    before do
      # Provide a mock fog connection
      allow(Fog::Storage).to receive(:new).with(
        { provider: "rackspace" }
      ).and_return(MockFogConnection.new)
    end

    it "yields to block" do
      expect { |b| GarbageMan::Manager.new("rackspace", { credentials: {}, keep: 4 }).cleanup!(&b) }.to yield_with_args(MockFogContainer.instance.files.first)
    end

    it "destroys correct number of files based on the keep setting" do
      expect(MockFogContainer.instance.files[0]).to receive(:destroy)
      expect(MockFogContainer.instance.files[1]).to receive(:destroy)

      count = GarbageMan::Manager.new("rackspace", { credentials: {}, keep: 3 }).cleanup!
      expect(count).to eq 2
    end

    it "skips destruction if dry_run is enabled" do
      expect_any_instance_of(MockFogFile).to_not receive(:destroy)

      GarbageMan::Manager.new("rackspace", { credentials: {}, keep: 3, dry_run: true }).cleanup!
    end
  end
end
