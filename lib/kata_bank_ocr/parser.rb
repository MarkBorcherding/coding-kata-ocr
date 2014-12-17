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

    #
    # Parse a line into the appropriate digits
    #
    # Assumptions
    # * line will be a string with 3 lines separated by \n
    # * each line will contain 3 * n characters
    def self.digits(line)
      top,
      middle,
      bottom = *line.split("\n")
                .map(&:chars)
                .map { |l| l.each_slice(3) }

      top.map do |t|
        [t, middle.next, bottom.next]
      end
    end
  end
end
