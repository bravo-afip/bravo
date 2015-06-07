require 'spec_helper'

describe 'Wsaa' do
  before do
    @now = (Time.now) - 120
    @from = @now.strftime('%FT%T%:z')
    @to   = (@now + ((12 * 60 * 60))).strftime('%FT%T%:z')
    @id   = @now.strftime('%s')
    @tra  = <<-EOF
<?xml version="1.0" encoding="UTF-8"?>
<loginTicketRequest version="1.0">
  <header>
    <uniqueId>#{ @id }</uniqueId>
    <generationTime>#{ @from }</generationTime>
    <expirationTime>#{ @to }</expirationTime>
  </header>
  <service>wsfe</service>
</loginTicketRequest>
EOF
  end

  describe '.build_tra' do
    it 'sets the body for the ticket request' do
      expect(Bravo::Wsaa.build_tra).to eq @tra
    end
  end

  describe '.build_cms' do
    pending 'returns the cms with the tra in it' do
      expect(false).to be_truthy
    end
  end

  describe '.login' do
    it 'writes the auth file', vcr: { cassette_name: 'login' } do
      expect(File).to receive(:write)
      Bravo::Wsaa.login_to_file('/tmp/bravo_test.yml', 'spec/fixtures/certs/pkey',
        'spec/fixtures/certs/cert.crt')
    end
  end
end
