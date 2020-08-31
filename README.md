# Asca

[![GitHub license](https://img.shields.io/github/license/xueminghao/appstoreconnectapi)](https://github.com/xueminghao/appstoreconnectapi/blob/master/LICENSE.txt)
[![Gem](https://img.shields.io/gem/v/asca)](https://rubygems.org/gems/asca)

An apple app store connect api wrapper based on ruby!!!

Why ruby?

Every mac's ready for ruby out of the box!!!

## Installation

Install from rubygem.org

``` sh
gem install asca
```

Install from github

``` sh
gem install specific_install
gem specific_install https://github.com/xueminghao/appstoreconnectapi.git
```

## What you need

1. App store connect key id
1. App store connect issuer ID
1. App store connect private key

For more details for how and where to get these info, you can refer to the [App Store Connect API](https://developer.apple.com/documentation/appstoreconnectapi/generating_tokens_for_api_requests)

## Usage

First of all, one should setup a its credentials as described above. Then you can ever call basic REST apis or call the useful tools. To call a tools use --tools [tool-name], to call a api use --api [api-name]

* Register device tool. Which register a new device to your current team and update the specified provisioning files

```ruby
asca --tools register-device -a profile-download -n [profile-name]
```

* Download provisioning file tool. Which download specified provisioning file to local disk and install it as needed

```ruby
asca --tools download-profile --name [profile-name] --auto-install
```

* Call device get api, you can call list the all registered devices.

```ruby
asca --api device --method get
```

## TODO

Fulfill all of the REST apis

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/xueminghao/appstoreconnectapi. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
