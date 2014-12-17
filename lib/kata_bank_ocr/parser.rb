module KataBankOcr
  # The class to parse an input file.
  class Parser
    #
    # Group the lines of the file into logical lines
    #
    # Returns:
    #  An array of strings - Each string being having three
    #                        separate lines of the un-OCR'd
    #                        account number.
    #
    # Assumptions:
    #  * Lines will only appear in groups of 4
    #  * There is no use in keeping the line of empty spaces
    def self.lines(string_of_lines)
      string_of_lines
        .to_s
        .split("\n")
        .each_slice(4)
        .map { |l| l[0..-2] }
        .map { |l| l.join("\n") }
    end

    #
    # Parse a line into the appropriate digits
    #
    # Returns:
    # An Array of digits - Each member of the array is an
    #                      array of the top, middle and bottom
    #                      line of the un-OCR'd account number.
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

    #
    # Turn a digit into a character representation
    #
    def self.digit_to_char(digit)
      {
        ' _ | ||_|' => '0',
        '     |  |' => '1'
      }[digit.flatten.join('')]
    end
  end
end
