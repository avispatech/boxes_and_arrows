# frozen_string_literal: true

require_relative 'lib/boxes_and_arrows/version'

Gem::Specification.new do |spec|
  spec.name = 'boxes_and_arrows'
  spec.version = BoxesAndArrows::VERSION
  spec.authors = ['Leonardo Luarte G']
  spec.email = ['leonardo@luarte.net']

  spec.summary = 'Makes Boxes'
  spec.description = 'Makes boxes'
  spec.homepage = 'https://github.com/avispatech/boxes_and_arrows'
  spec.license = 'MIT'
  spec.required_ruby_version = '>= 2.6.0'

  spec.metadata['allowed_push_host'] = 'https://avispa.tech/boxes_and_arrows'

  spec.metadata['homepage_uri'] = spec.homepage
  spec.metadata['source_code_uri'] = 'https://github.com/avispatech/boxes_and_arrows'
  spec.metadata['changelog_uri'] = 'https://github.com/avispatech/boxes_and_arrows/changelog.md'

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(__dir__) do
    `git ls-files -z`.split("\x0").reject do |f|
      (f == __FILE__) || f.match(%r{\A(?:(?:bin|test|spec|features)/|\.(?:git|travis|circleci)|appveyor)})
    end
  end
  spec.bindir = 'exe'
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  # Uncomment to register a new dependency of your gem
  # spec.add_dependency "example-gem", "~> 1.0"
  spec.add_dependency 'hashie', '~>5.0'
  spec.add_dependency 'nokogiri'

  spec.add_development_dependency 'codecov', '~> 0.1'
  spec.add_development_dependency 'debug'
  spec.add_development_dependency 'dotenv', '~> 2.5'
  spec.add_development_dependency 'rails', '~> 6.0.3'
  spec.add_development_dependency 'rake', '~> 13.0'
  spec.add_development_dependency 'rspec', '~> 3.6'
  spec.add_development_dependency 'rspec-rails', '~> 4.0'
  # rubocop dependencies...
  spec.add_development_dependency 'rubocop'
  spec.add_development_dependency 'rubocop-rspec'
  spec.add_development_dependency 'simplecov', '~> 0.16'

  # For more information and examples about making a new gem, check out our
  # guide at: https://bundler.io/guides/creating_gem.html
end
