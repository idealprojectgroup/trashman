module GarbageMan
  module VERSION
    MAJOR = 0
    MINOR = 0
    TINY  = 1
    PRE   = "pre"

    STRING = [MAJOR, MINOR, TINY, PRE].compact.join('.')

    def self.to_s
      STRING
    end
  end

  def self.version
    VERSION::STRING
  end
end
