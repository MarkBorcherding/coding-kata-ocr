module KataBankOcr
  # The class to parse an input file.
  class Parser
    #
    # Group the lines of the file into logical lines
    #
    # Assumptions:
    #  * Lines will only appear in groups of 4
    def self.lines(string_of_lines)
      l = []
      string_of_lines
        .split("\n")
        .each_slice(4) { |a| l << a[0..-2].join("\n") }
      l
    end
  end
end
