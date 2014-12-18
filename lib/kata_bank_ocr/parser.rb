module KataBankOcr
  # The class to parse an input file.
  class Parser
    # Group the lines of the file into logical lines
    #
    # @param string_of_lines [String] A string containins several lines of
    #                                 un-OCR'd account numbers. These lines
    #                                 are always in multiples of 4, with the
    #                                 last line being completely empty, and
    #                                 also needed only to delimiate the lines.
    #
    # @return [Array<String>] An array of strings. Each string being having
    #                         three separate lines of the un-OCR'd account
    #                         number.
    def self.lines(string_of_lines)
      string_of_lines
        .to_s
        .split("\n", -1)
        .each_slice(4)
        .map { |l| l[0..-2] }
        .map { |l| l.join("\n") }
    end

    # Parse a line into the appropriate digits
    #
    # @param [String] line A string containing the un-OCR'd digit, including
    #                      new line characters. The line should have three
    #                      lines of characters. Each of the lines should be in
    #                      multiples of 3, since each digit is expected to be
    #                      3 characters.
    #
    # @return [Array<Array<String>>] An Array of digits. Each member of the
    #                                array is an array of the top, middle
    #                                and bottom line of the un-OCR'd account
    #                                number.
    def self.digits(line)
      top,
      middle,
      bottom = *line.split("\n")
                .map(&:chars)
                .map { |l| l.each_slice(3) }

      top.zip middle, bottom
    end

    #
    # Turn a digit into a character representation
    #
    # Parameters:
    # @param [Array<Array<String>>] digit An array containing arrays of the
    #                                     top, bottom, and middle characters
    #                                     of the digit.
    #
    # @return [String] A string containing a one character representation of
    #                  the digit.
    #
    def self.digit_to_char(digit)
      {
        flatten(' _ ',
                '| |',
                '|_|') => '0',

        flatten('   ',
                '  |',
                '  |') => '1',

        flatten(' _ ',
                ' _|',
                '|_ ') => '2',

        flatten(' _ ',
                ' _|',
                ' _|') => '3',

        flatten('   ',
                '|_|',
                '  |') => '4',

        flatten(' _ ',
                '|_ ',
                ' _|') => '5',

        flatten(' _ ',
                '|_ ',
                '|_|') => '6',

        flatten(' _ ',
                '  |',
                '  |') => '7',

        flatten(' _ ',
                '|_|',
                '|_|') => '8',

        flatten(' _ ',
                '|_|',
                ' _|') => '9'

      }[flatten(*digit)]
    end

    def self.flatten(*lines)
      lines.flatten.join('')
    end
    private_class_method :flatten
  end
end
