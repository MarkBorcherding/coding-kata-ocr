require_relative '../../lib/kata_bank_ocr/parser'
module KataBankOcr
  RSpec.describe Parser do
    describe '#lines' do
      it 'groups 4 lines of the file into one logical line' do
        file = %w( 11
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
                   34).join("\n")

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

    describe '#digit_to_char' do
      shared_examples_for 'a parsed digit' do |char, *digit|
        it "parses the digit #{char}" do
          expect(Parser.digit_to_char(digit)).to eq(char)
        end
      end

      it_behaves_like 'a parsed digit', '0', ' _ ',
                                             '| |',
                                             '|_|'

      it_behaves_like 'a parsed digit', '1', '   ',
                                             '  |',
                                             '  |'

      it_behaves_like 'a parsed digit', '2', ' _ ',
                                             ' _|',
                                             '|_ '

      it_behaves_like 'a parsed digit', '3', ' _ ',
                                             ' _|',
                                             ' _|'

      it_behaves_like 'a parsed digit', '4', '   ',
                                             '|_|',
                                             '  |'

      it_behaves_like 'a parsed digit', '5', ' _ ',
                                             '|_ ',
                                             ' _|'

      it_behaves_like 'a parsed digit', '6', ' _ ',
                                             '|_ ',
                                             '|_|'

      it_behaves_like 'a parsed digit', '7', ' _ ',
                                             '  |',
                                             '  |'

      it_behaves_like 'a parsed digit', '8', ' _ ',
                                             '|_|',
                                             '|_|'

      it_behaves_like 'a parsed digit', '9', ' _ ',
                                             '|_|',
                                             ' _|'
    end
  end
end
