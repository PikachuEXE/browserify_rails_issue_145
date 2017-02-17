module Sprockets
  class DoNothingCompressor
    def compress(string)
      # do nothing
      string
    end
  end
end
