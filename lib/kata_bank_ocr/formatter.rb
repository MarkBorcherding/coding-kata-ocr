require_relative 'parser'
module KataBankOcr
  # The class to format text output for a line
  module Formatter
    # Format an account number for output
    #
    # Format the line with the appropriate `ERR` or `ILL` suffix after the
    # account number.
    #
    # @example A valid account number
    #   000000051
    #
    # @example An illegible account number
    #   49006771? ILL
    #
    # @example An account number with a checksum error
    #   444444444 ERR
    #
    # @param [String] account_number The account number to format.
    # @return [String] Th formatted line with appropriate suffix.
    def self.format(account_number)
      "#{account_number}#{illegible(account_number)}#{checksum(account_number)}"
    end

    def self.illegible(account_number)
      ' ILL' unless Parser.legible? account_number
    end
    private_class_method :illegible

    def self.checksum(account_number)
      ' ERR' if  Parser.legible?(account_number) &&
                 !Checksum.valid?(account_number)
    end
    private_class_method :checksum
  end
end
