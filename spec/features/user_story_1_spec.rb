require_relative '../../lib/kata_bank_ocr/parser'

RSpec.shared_examples_for 'a parsed account number' do |account_number, *line|
  it "parses #{account_number}" do
    lines = line.join "\n"
    expect(KataBankOcr::Parser.parse(lines)).to match_array([account_number])
  end
end

RSpec.shared_examples_for 'a parsed file' do |account_number|
  it "parses a file #{account_number}" do
    file = File.join File.dirname(__FILE__), 'fixtures', "#{account_number}.txt"
    expect(KataBankOcr::Parser.parse_file file).to match_array([account_number])
  end
end

RSpec.describe 'User Story 1' do
  it_behaves_like 'a parsed file', '000000000'

  it_behaves_like 'a parsed account number', '000000000',
                  ' _  _  _  _  _  _  _  _  _ ',
                  '| || || || || || || || || |',
                  '|_||_||_||_||_||_||_||_||_|',
                  ''

  it_behaves_like 'a parsed account number', '111111111',
                  '                           ',
                  '  |  |  |  |  |  |  |  |  |',
                  '  |  |  |  |  |  |  |  |  |',
                  ''

  it_behaves_like 'a parsed account number', '222222222',
                  ' _  _  _  _  _  _  _  _  _ ',
                  ' _| _| _| _| _| _| _| _| _|',
                  '|_ |_ |_ |_ |_ |_ |_ |_ |_ ',
                  ''

  it_behaves_like 'a parsed account number', '333333333',
                  ' _  _  _  _  _  _  _  _  _ ',
                  ' _| _| _| _| _| _| _| _| _|',
                  ' _| _| _| _| _| _| _| _| _|',
                  ''

  it_behaves_like 'a parsed account number', '444444444',
                  '                           ',
                  '|_||_||_||_||_||_||_||_||_|',
                  '  |  |  |  |  |  |  |  |  |',
                  ''

  it_behaves_like 'a parsed account number', '555555555',
                  ' _  _  _  _  _  _  _  _  _ ',
                  '|_ |_ |_ |_ |_ |_ |_ |_ |_ ',
                  ' _| _| _| _| _| _| _| _| _|',
                  ''

  it_behaves_like 'a parsed account number', '666666666',
                  ' _  _  _  _  _  _  _  _  _ ',
                  '|_ |_ |_ |_ |_ |_ |_ |_ |_ ',
                  '|_||_||_||_||_||_||_||_||_|',
                  ''

  it_behaves_like 'a parsed account number', '777777777',
                  ' _  _  _  _  _  _  _  _  _ ',
                  '  |  |  |  |  |  |  |  |  |',
                  '  |  |  |  |  |  |  |  |  |',
                  ''

  it_behaves_like 'a parsed account number', '888888888',
                  ' _  _  _  _  _  _  _  _  _ ',
                  '|_||_||_||_||_||_||_||_||_|',
                  '|_||_||_||_||_||_||_||_||_|',
                  ''

  it_behaves_like 'a parsed account number', '999999999',
                  ' _  _  _  _  _  _  _  _  _ ',
                  '|_||_||_||_||_||_||_||_||_|',
                  ' _| _| _| _| _| _| _| _| _|',
                  ''

  it_behaves_like 'a parsed account number', '123456789',
                  '    _  _     _  _  _  _  _ ',
                  '  | _| _||_||_ |_   ||_||_|',
                  '  ||_  _|  | _||_|  ||_| _|',
                  ''
end
