module KataBankOcr
  # Run checksum validation on an account number
  module Checksum
    # Check the checksum of the account number
    #
    # @param account_number [String] The account number to
    #                                test
    #
    # @return [Boolean] `true` if the checksum is valid
    def self.valid?(account_number)
      sum = account_number
            .chars
            .map(&:to_i)
            .reverse
            .each_with_index
            .reduce(0) do |a, e|
              a + (e[0] * (e[1] + 1))
            end
      (sum % 11) == 0
    end
  end
end
