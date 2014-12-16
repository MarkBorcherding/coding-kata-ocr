require_relative '../../lib/kata_bank_ocr/parser'
module KataBankOcr
  describe Parser do
    describe '#lines' do
      it 'groups 4 lines of the file into one logical line' do
        file = <<-EOF
11
12
13
14
21
22
23
24
31
32
33
34
EOF

        expect(KataBankOcr::Parser.lines(file)).to eq [
          %w( 11 12 13 14 ),
          %w( 21 22 23 24 ),
          %w( 31 32 33 34 )
        ]
      end
    end
    describe 'parsing a line into 9 digits'
    describe 'parsing 1'
    describe 'parsing 2'
    describe 'parsing 3'
    describe 'parsing 4'
    describe 'parsing 5'
    describe 'parsing 6'
    describe 'parsing 7'
    describe 'parsing 8'
    describe 'parsing 9'
  end
end
