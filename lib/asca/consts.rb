module Asca
    SCHEME = 'https'
    HOST = 'api.appstoreconnect.apple.com'

    def Asca.url_for_path(path)
        return SCHEME + '://' + HOST + '/' + path
    end

    URI_PROFILES = url_for_path('v1/profiles')
end