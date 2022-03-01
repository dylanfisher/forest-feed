require_relative "lib/forest/feed/version"

Gem::Specification.new do |spec|
  spec.name        = "forest-feed"
  spec.version     = Forest::Feed::VERSION
  spec.authors     = ["dylanfisher"]
  spec.email       = ["hi@dylanfisher.com"]
  spec.homepage    = "https://github.com/dylanfisher/forest-feed"
  spec.summary     = "Instagram support in Forest CMS"
  spec.description = "A Rails engine that uses Instagram's Basic Display API to sync posts to Forest CMS."
  spec.license     = "MIT"
  
  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the "allowed_push_host"
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  spec.metadata["allowed_push_host"] = "TODO: Set to 'http://mygemserver.com'"

  spec.metadata["homepage_uri"] = spec.homepage
  # spec.metadata["source_code_uri"] = "TODO: Put your gem's public repo URL here."
  # spec.metadata["changelog_uri"] = "TODO: Put your gem's CHANGELOG.md URL here."

  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]
  end

  spec.add_dependency "rails"
  spec.add_dependency "faraday"
end
