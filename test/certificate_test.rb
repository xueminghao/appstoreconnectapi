require "test_helper"

class CertificateTest < Minitest::Test
    def test_list_certificates
        puts 'Request all certificates'
        assert Asca::Certificates.list_certificates
        puts "Request dev certificates only"
        assert Asca::Certificates.list_certificates "DEVELOPMENT"
        puts "Request relese certificates only"
        assert Asca::Certificates.list_certificates "DISTRIBUTION"
    end
end