
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "json_deep_parse/version"

Gem::Specification.new do |spec|
  spec.name          = "json_deep_parse"
  spec.version       = JsonDeepParse::VERSION
  spec.authors       = ["bnbry"]
  spec.email         = ["mbanbury@gmail.com"]

  spec.summary       = "Deeply parse heavily escaped and nested JSON"
  spec.homepage      = "https://github.com/bnbry/json_deep_parse"
  spec.license       = "MIT"

  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "json", "~> 2.0"

  spec.add_development_dependency "bundler", "~> 2.0"
  spec.add_development_dependency "rake", "~> 12.3.3"
  spec.add_development_dependency "minitest", "~> 5.0"
end
