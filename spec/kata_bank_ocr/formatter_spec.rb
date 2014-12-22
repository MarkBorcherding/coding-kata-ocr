require_relative '../../lib/kata_bank_ocr/formatter'
require_relative '../../lib/kata_bank_ocr/checksum'
module KataBankOcr
  RSpec.describe Formatter do
    describe '#format' do
      let(:account_number) { '123456789' }
      let(:legible) { true }
      before do
        allow(Parser).to receive(:legible?)
          .with(account_number)
          .and_return(legible)
      end

      context 'when the account number is legible' do
        it 'displays the account number' do
          expect(Formatter.format(account_number)).to eq('123456789')
        end
      end

      context 'when the account number is illegible' do
        let(:legible) { false }
        it 'displays the account number and ILL' do
          expect(Formatter.format(account_number)).to eq('123456789 ILL')
        end
      end

      context 'when the account number has a check sum error' do
        before do
          allow(Checksum).to receive(:valid?)
            .with(account_number)
            .and_return(false)
        end

        it 'displays the account number and ERR' do
          expect(Formatter.format(account_number)).to eq('123456789 ERR')
        end
      end
    end
  end
end
