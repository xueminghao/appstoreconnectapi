lib = File.expand_path("lib", __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "asca/version"

Gem::Specification.new do |spec|
  spec.name          = "asca"
  spec.version       = Asca::VERSION
  spec.authors       = ["xueminghao"]
  spec.email         = ["minghaoxue@clubfactory.com"]

  spec.summary       = %q{A ruby wrapper for apple store connect api}
  spec.description   = %q{A ruby wrapper for apple store connect api}
  spec.homepage      = "https://github.com/xueminghao/appstoreconnectapi"
  spec.license       = "MIT"


  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/xueminghao/appstoreconnectapi.git"
  spec.metadata["changelog_uri"] = "https://github.com/xueminghao/appstoreconnectapi.git"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 2.0"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "minitest", "~> 5.0"
  spec.add_dependency "json"
  #https://github.com/httprb/http/wiki
  spec.add_dependency "http"
  spec.add_dependency 'jwt'
end
