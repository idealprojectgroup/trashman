require 'garbage_man/cli'

describe GarbageMan::CLI do
  describe ".prune" do
    it "provides help" do
      expect {
        GarbageMan::CLI.start(["help"])
      }.to output(/prune/).to_stdout
    end
  end
end
