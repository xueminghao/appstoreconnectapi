require "test_helper"

class CertificateTest < Minitest::Test
    def test_list_certificates
        puts 'Request all certificates'
        assert Asca::REST::Provisioning::Certificates.list_certificates
        puts "Request dev certificates only"
        assert Asca::REST::Provisioning::Certificates.list_certificates :typ => "DEVELOPMENT"
        puts "Request relese certificates only"
        assert Asca::REST::Provisioning::Certificates.list_certificates :type => "DISTRIBUTION"
    end
end