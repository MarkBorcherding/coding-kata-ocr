require_relative '../../lib/kata_bank_ocr/checksum'

RSpec.describe 'User Story 2' do
  context 'checking an account number checksum' do
    %w( 711111111
        123456789
        490867715
        000000051).each do |valid|
      it "affirms #{valid} is a valid account number" do
        expect(KataBankOcr::Checksum.valid?(valid)).to eq(true)
      end
    end

    %w( 888888888
        490067715
        012345678).each do |invalid|
      it "invalidates #{invalid} as a valid account number" do
        expect(KataBankOcr::Checksum.valid?(invalid)).to eq(false)
      end
    end
  end
end
