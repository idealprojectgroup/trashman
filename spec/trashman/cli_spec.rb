require 'trashman/cli'

describe TrashMan::CLI do
  describe ".prune" do
    it "provides help" do
      expect {
        TrashMan::CLI.start(["help"])
      }.to output(/prune/).to_stdout
    end
  end
end
