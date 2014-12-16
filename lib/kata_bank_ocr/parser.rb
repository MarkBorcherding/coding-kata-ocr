module KataBankOcr
  # The class to parse an input file.
  class Parser
    # Group the lines of the file into logical lines
    def self.lines(read_lines)
      l = []
      read_lines.split("\n").each_slice(4) { |a| l << a }
      l
    end
  end
end
