# Asca

An apple app store connect api wrapper based on ruby!!!

Why ruby?

Every mac's ready for ruby out of the box!!!

## Installation

Add this line to your application's Gemfile:

```ruby
gem install specific_install
gem specific_install https://github.com/xueminghao/appstoreconnectapi.git
```

## Usage

* Download provisioning files by name from developer account

```ruby
asca -a profile-download -n [profile-name]
```

* Download & install provisioning files by name from developer account

```ruby
asca -a profile-install -n [profile-name]
```

## TODO

Support more actions such as device management


## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/xueminghao/appstoreconnectapi. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
