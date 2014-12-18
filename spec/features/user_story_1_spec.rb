require_relative '../../lib/kata_bank_ocr/parser'

RSpec.shared_examples_for 'a parsed account number' do |account_number, line|
  it 'parses ' do
    pending 'still working on parse'
    expect(KataBankOcr::Parser.parse(line)).to eq(account_number)
  end
end

RSpec.describe 'User Story 1' do
  it_behaves_like 'a parsed account number', '000000000', <<-EOF
 _  _  _  _  _  _  _  _  _
| || || || || || || || || |
|_||_||_||_||_||_||_||_||_|
EOF

  it_behaves_like 'a parsed account number', '111111111', <<-EOF
  |  |  |  |  |  |  |  |  |
  |  |  |  |  |  |  |  |  |
EOF

  it_behaves_like 'a parsed account number', '222222222', <<-EOF
 _  _  _  _  _  _  _  _  _
 _| _| _| _| _| _| _| _| _|
|_ |_ |_ |_ |_ |_ |_ |_ |_
EOF

  it_behaves_like 'a parsed account number', '333333333', <<-EOF
 _  _  _  _  _  _  _  _  _
 _| _| _| _| _| _| _| _| _|
 _| _| _| _| _| _| _| _| _|
EOF

  it_behaves_like 'a parsed account number', '444444444', <<-EOF

|_||_||_||_||_||_||_||_||_|
  |  |  |  |  |  |  |  |  |
EOF

  it_behaves_like 'a parsed account number', '555555555', <<-EOF
 _  _  _  _  _  _  _  _  _
|_ |_ |_ |_ |_ |_ |_ |_ |_
 _| _| _| _| _| _| _| _| _|

EOF

  it_behaves_like 'a parsed account number', '666666666', <<-EOF
 _  _  _  _  _  _  _  _  _
|_ |_ |_ |_ |_ |_ |_ |_ |_
|_||_||_||_||_||_||_||_||_|

EOF

  it_behaves_like 'a parsed account number', '777777777', <<-EOF
 _  _  _  _  _  _  _  _  _
  |  |  |  |  |  |  |  |  |
  |  |  |  |  |  |  |  |  |

EOF

  it_behaves_like 'a parsed account number', '888888888', <<-EOF
 _  _  _  _  _  _  _  _  _
|_||_||_||_||_||_||_||_||_|
|_||_||_||_||_||_||_||_||_|

EOF

  it_behaves_like 'a parsed account number', '999999999', <<-EOF
 _  _  _  _  _  _  _  _  _
|_||_||_||_||_||_||_||_||_|
 _| _| _| _| _| _| _| _| _|

EOF

  it_behaves_like 'a parsed account number', '123456789', <<-EOF
    _  _     _  _  _  _  _
  | _| _||_||_ |_   ||_||_|
  ||_  _|  | _||_|  ||_| _|

EOF
end
