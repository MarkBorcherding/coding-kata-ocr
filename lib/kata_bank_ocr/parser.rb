module KataBankOcr
  # The class to parse an input file.
  module Parser
    # Group the lines of the file into logical lines
    #
    # @param [String] string_of_lines A string containins several lines of
    #                                 un-OCR'd account numbers. These lines
    #                                 are always in multiples of 4, with the
    #                                 last line being completely empty, and
    #                                 also needed only to delimiate the lines.
    #
    # @return [Enumerable<String>] An array of strings. Each string being having
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

    # Parse a file and turn it into account numbers
    #
    # @param [String] filename The name of the file to parse into account
    #                          numbers
    #
    # @return [Enumerable<String>] An enumerator of account numbers
    def self.parse_file(filename)
      parse File.read(filename)
    end

    # Parse lines and turn them into account numbers
    #
    # @param [String] all_lines A string containing all the lines to parsed
    #
    # @return [Enumerable<String>] An enumerator of account numbers
    def self.parse(all_lines)
      lines(all_lines)
        .map(&method(:parse_line))
    end

    # Parse a single line into a string representing the account number
    #
    # @param [String] line The un-OCR'd account number
    #
    # @return [String] An account number
    def self.parse_line(line)
      digits(line)
        .map(&method(:digit_to_char))
        .reduce(&:+)
    end

    # Parse a line into the appropriate digits
    #
    # @param [String] line A string containing the un-OCR'd digit, including
    #                      new line characters. The line should have three
    #                      lines of characters. Each of the lines should be in
    #                      multiples of 3, since each digit is expected to be
    #                      3 characters.
    #
    # @return [Enumerable<Enumerable<String>>] An Enumerable of digits. Each
    #                                member of the array is an array of the
    #                                top, middle and bottom line of the
    #                                un-OCR'd account number.
    def self.digits(line)
      top,
      middle,
      bottom = *line.split("\n")
                .map(&:chars)
                .map { |l| l.each_slice(3) }

      top.zip middle, bottom
    end

    # Turn a digit into a character representation
    #
    # This method is open for some memoization, but skipping for now do to
    # time constraints.
    #
    # @param [Enumerable<Enumerable<String>>] digit An array containing arrays
    #                                               of the top, bottom, and
    #                                               middle characters of the
    #                                               digit.
    #
    # @return [String] A string containing a one character representation of
    #                  the digit.
    #
    def self.digit_to_char(digit)
      digits = {
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

      }
      digits.default = '?'
      digits[flatten(*digit)]
    end

    # Determines if an account number was completely read
    #
    # @param [String] account_number The account number to test
    # @return Truthy if the account number if completely read.
    def self.legible?(account_number)
      /^\d{9}$/ =~ account_number
    end

    def self.flatten(*lines)
      lines
        .flatten
        .join('')
    end
    private_class_method :flatten
  end
end
