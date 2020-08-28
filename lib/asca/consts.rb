module Asca
    SCHEME = 'https'
    HOST = 'api.appstoreconnect.apple.com'

    def Asca.url_for_path(path)
        return SCHEME + '://' + HOST + '/' + path
    end

    URI_PROFILES = url_for_path('v1/profiles')
    URI_DEVICES = url_for_path('v1/devices')
    URI_CERTIFICATES = url_for_path('v1/certificates')
    URI_BUNDLEIDS = url_for_path('v1/bundleIds')
end