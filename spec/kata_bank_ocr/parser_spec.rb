require_relative '../../lib/kata_bank_ocr/parser'
module KataBankOcr
  RSpec.describe Parser do
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

        expect(Parser.lines(file)).to eq %W(
          11\n12\n13
          21\n22\n23
          31\n32\n33
        )
      end
    end

    describe 'parsing a line into digits' do
      describe '#digits' do
        let(:line) do
          <<-EOF
111222333444555666777888999
111222333444555666777888999
111222333444555666777888999
EOF
        end

        it 'divides a line into 9 digits' do
          expect(Parser.digits(line).count).to eq(9)
        end

        it 'groups the top, middle and bottom into the digit' do
          expect(Parser.digits(line)).to all(satisfy { |x| x.length == 3 })
        end

        it 'groups the each digits characters' do
          digits = Parser.digits(line)
          (1..9).each do |index|
            expect(digits[index - 1].flatten).to all eq("#{index}")
          end
        end
      end
    end

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
