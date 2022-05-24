The purpose of this repository is to demonstrate a bug in bundler, both `2.3.14` and latest `master @ 20e9b96b9`, with various versions of Ruby.

The primary cause seems to be inclusion of a gem that has a severe `required_ruby_version`, and which precludes it from working for both the current library, and/or the current runtime.

---

_I won't make a branch for each of the broken examples, as the matrix of affected combinations is pretty big._
_I will do one for current latest releases of bundler and ruby, and one for the HEADs._

- HEADS @ [branch main](https://github.com/rubocop-lts/bundler-required_ruby_version-bug/tree/main)
- current releases @ [branch current](https://github.com/rubocop-lts/bundler-required_ruby_version-bug/tree/current)

# CURRENT RELEASES

This branch contains the ERROR REPORT for `ruby 3.1.2` + `bundler 2.3.14`.

---

<details>
  <summary>NOTE: There is one combination that works: `ruby 3.2.0-preview1` + `bundler-2.4.0.dev (default gem)`</summary>
# What working looks like

```shell
bundle install
Fetching gem metadata from https://rubygems.org/...........
Resolving dependencies...
Bundler found conflicting requirements for the Ruby version:
  In Gemfile:
    bundler-required_ruby_version-bug was resolved to 0.1.0, which depends on
      Ruby (>= 2.4.0)

    rubocop-lts (~> 3.0) was resolved to 3.0.2, which depends on
      Ruby (< 2.1, >= 2.0.0)
```

When your local ruby is:
```
MRI 3.2.0-preview1
```

When your local bundler version is:
```
bundler-2.4.0.dev (default gem)
```

NOTE:
- It doesn't work when you install rubygems from latest source and `ruby setup.rb`.
- Somehow the included rubygems in 3.2.0-preview1 doesn't exhibit this bug, while latest released version, and latest source do.
</details>

# The bug

When your local ruby is one of:
```
2.6.10
2.7.6
3.0.4
3.1.2
3.2.0-preview1
```

When local bundler version is:
```
2.3.14
2.4.0.dev (ruby setup.rb @ 20e9b96b9 Merge pull request #5560 from mame/support-disabled_message)
```

## Run

```shell
❯ bundle update
Fetching gem metadata from https://rubygems.org/...........
Resolving dependencies...
```

## Error:

--- ERROR REPORT TEMPLATE -------------------------------------------------------

```
NoMethodError: undefined method `name' for nil:NilClass

      msg = String.new(dep.name)
                  ^^^^^
  /Users/pboling/.asdf/installs/ruby/3.1.2/lib/ruby/site_ruby/3.1.0/bundler/shared_helpers.rb:167:in `pretty_dependency'
  /Users/pboling/.asdf/installs/ruby/3.1.2/lib/ruby/site_ruby/3.1.0/bundler/resolver.rb:396:in `block in version_conflict_message'
  /Users/pboling/.asdf/installs/ruby/3.1.2/lib/ruby/site_ruby/3.1.0/bundler/vendor/molinillo/lib/molinillo/errors.rb:145:in `block in message_with_trees'
  /Users/pboling/.asdf/installs/ruby/3.1.2/lib/ruby/site_ruby/3.1.0/bundler/vendor/molinillo/lib/molinillo/errors.rb:144:in `each'
  /Users/pboling/.asdf/installs/ruby/3.1.2/lib/ruby/site_ruby/3.1.0/bundler/vendor/molinillo/lib/molinillo/errors.rb:144:in `reduce'
  /Users/pboling/.asdf/installs/ruby/3.1.2/lib/ruby/site_ruby/3.1.0/bundler/vendor/molinillo/lib/molinillo/errors.rb:144:in `message_with_trees'
  /Users/pboling/.asdf/installs/ruby/3.1.2/lib/ruby/site_ruby/3.1.0/bundler/resolver.rb:315:in `version_conflict_message'
  /Users/pboling/.asdf/installs/ruby/3.1.2/lib/ruby/site_ruby/3.1.0/bundler/resolver.rb:56:in `rescue in start'
  /Users/pboling/.asdf/installs/ruby/3.1.2/lib/ruby/site_ruby/3.1.0/bundler/resolver.rb:44:in `start'
  /Users/pboling/.asdf/installs/ruby/3.1.2/lib/ruby/site_ruby/3.1.0/bundler/resolver.rb:23:in `resolve'
  /Users/pboling/.asdf/installs/ruby/3.1.2/lib/ruby/site_ruby/3.1.0/bundler/definition.rb:270:in `resolve'
  /Users/pboling/.asdf/installs/ruby/3.1.2/lib/ruby/site_ruby/3.1.0/bundler/definition.rb:181:in `resolve_remotely!'
  /Users/pboling/.asdf/installs/ruby/3.1.2/lib/ruby/site_ruby/3.1.0/bundler/installer.rb:280:in `resolve_if_needed'
  /Users/pboling/.asdf/installs/ruby/3.1.2/lib/ruby/site_ruby/3.1.0/bundler/installer.rb:82:in `block in run'
  /Users/pboling/.asdf/installs/ruby/3.1.2/lib/ruby/site_ruby/3.1.0/bundler/process_lock.rb:12:in `block in lock'
  /Users/pboling/.asdf/installs/ruby/3.1.2/lib/ruby/site_ruby/3.1.0/bundler/process_lock.rb:9:in `open'
  /Users/pboling/.asdf/installs/ruby/3.1.2/lib/ruby/site_ruby/3.1.0/bundler/process_lock.rb:9:in `lock'
  /Users/pboling/.asdf/installs/ruby/3.1.2/lib/ruby/site_ruby/3.1.0/bundler/installer.rb:71:in `run'
  /Users/pboling/.asdf/installs/ruby/3.1.2/lib/ruby/site_ruby/3.1.0/bundler/installer.rb:23:in `install'
  /Users/pboling/.asdf/installs/ruby/3.1.2/lib/ruby/site_ruby/3.1.0/bundler/cli/install.rb:62:in `run'
  /Users/pboling/.asdf/installs/ruby/3.1.2/lib/ruby/site_ruby/3.1.0/bundler/cli.rb:255:in `block in install'
  /Users/pboling/.asdf/installs/ruby/3.1.2/lib/ruby/site_ruby/3.1.0/bundler/settings.rb:131:in `temporary'
  /Users/pboling/.asdf/installs/ruby/3.1.2/lib/ruby/site_ruby/3.1.0/bundler/cli.rb:254:in `install'
  /Users/pboling/.asdf/installs/ruby/3.1.2/lib/ruby/site_ruby/3.1.0/bundler/vendor/thor/lib/thor/command.rb:27:in `run'
  /Users/pboling/.asdf/installs/ruby/3.1.2/lib/ruby/site_ruby/3.1.0/bundler/vendor/thor/lib/thor/invocation.rb:127:in `invoke_command'
  /Users/pboling/.asdf/installs/ruby/3.1.2/lib/ruby/site_ruby/3.1.0/bundler/vendor/thor/lib/thor.rb:392:in `dispatch'
  /Users/pboling/.asdf/installs/ruby/3.1.2/lib/ruby/site_ruby/3.1.0/bundler/cli.rb:31:in `dispatch'
  /Users/pboling/.asdf/installs/ruby/3.1.2/lib/ruby/site_ruby/3.1.0/bundler/vendor/thor/lib/thor/base.rb:485:in `start'
  /Users/pboling/.asdf/installs/ruby/3.1.2/lib/ruby/site_ruby/3.1.0/bundler/cli.rb:25:in `start'
  /Users/pboling/.asdf/installs/ruby/3.1.2/lib/ruby/gems/3.1.0/gems/bundler-2.3.14/exe/bundle:48:in `block in <top (required)>'
  /Users/pboling/.asdf/installs/ruby/3.1.2/lib/ruby/site_ruby/3.1.0/bundler/friendly_errors.rb:103:in `with_friendly_errors'
  /Users/pboling/.asdf/installs/ruby/3.1.2/lib/ruby/gems/3.1.0/gems/bundler-2.3.14/exe/bundle:36:in `<top (required)>'
  /Users/pboling/.asdf/installs/ruby/3.1.2/bin/bundle:25:in `load'
  /Users/pboling/.asdf/installs/ruby/3.1.2/bin/bundle:25:in `<main>'
```

## Environment

```
Bundler       2.3.14
  Platforms   ruby, arm64-darwin-21
Ruby          3.1.2p20 (2022-04-12 revision 4491bb740a9506d76391ac44bb2fe6e483fec952) [arm64-darwin-21]
  Full Path   /Users/pboling/.asdf/installs/ruby/3.1.2/bin/ruby
  Config Dir  /Users/pboling/.asdf/installs/ruby/3.1.2/etc
RubyGems      3.3.14
  Gem Home    /Users/pboling/.asdf/installs/ruby/3.1.2/lib/ruby/gems/3.1.0
  Gem Path    /Users/pboling/.gem/ruby/3.1.0:/Users/pboling/.asdf/installs/ruby/3.1.2/lib/ruby/gems/3.1.0
  User Home   /Users/pboling
  User Path   /Users/pboling/.gem/ruby/3.1.0
  Bin Dir     /Users/pboling/.asdf/installs/ruby/3.1.2/bin
OpenSSL
  Compiled    OpenSSL 1.1.1n  15 Mar 2022
  Loaded      OpenSSL 1.1.1n  15 Mar 2022
  Cert File   /Users/pboling/.asdf/installs/ruby/3.1.2/openssl/ssl/cert.pem
  Cert Dir    /Users/pboling/.asdf/installs/ruby/3.1.2/openssl/ssl/certs
Tools
  Git         2.35.1
  RVM         not installed
  rbenv       not installed
  chruby      not installed
```

## Bundler Build Metadata

```
Built At          2022-05-18
Git SHA           467ad58a7c
Released Version  true
```

## Bundler settings

```
build.pg
  Set for the current user (/Users/pboling/.bundle/config): "--with-pg-config=/Users/pboling/.asdf/shims/pg_config"
gem.changelog
  Set for the current user (/Users/pboling/.bundle/config): true
gem.ci
  Set for the current user (/Users/pboling/.bundle/config): "github"
gem.coc
  Set for the current user (/Users/pboling/.bundle/config): true
gem.linter
  Set for the current user (/Users/pboling/.bundle/config): "rubocop"
gem.mit
  Set for the current user (/Users/pboling/.bundle/config): true
gem.test
  Set for the current user (/Users/pboling/.bundle/config): "rspec"
silence_root_warning
  Set for the current user (/Users/pboling/.bundle/config): true
with
  Set for your local app (/Users/pboling/src/bugs/bundler-required_ruby_version-bug/.bundle/config): [:api, :stats, :admin, :development, :test]
  Set for the current user (/Users/pboling/.bundle/config): [:api, :stats, :admin, :development, :test]
```

## Gemfile

### Gemfile

```ruby
# frozen_string_literal: true

source "https://rubygems.org"

# Specify your gem's dependencies in bundler-required_ruby_version-bug.gemspec
gemspec

gem "rake", "~> 13.0"

gem "rspec", "~> 3.0"
```

### Gemfile.lock

```
PATH
  remote: .
  specs:
    bundler-required_ruby_version-bug (0.1.0)

GEM
  remote: https://rubygems.org/
  specs:
    diff-lcs (1.5.0)
    rake (13.0.6)
    rspec (3.11.0)
      rspec-core (~> 3.11.0)
      rspec-expectations (~> 3.11.0)
      rspec-mocks (~> 3.11.0)
    rspec-core (3.11.0)
      rspec-support (~> 3.11.0)
    rspec-expectations (3.11.0)
      diff-lcs (>= 1.2.0, < 2.0)
      rspec-support (~> 3.11.0)
    rspec-mocks (3.11.1)
      diff-lcs (>= 1.2.0, < 2.0)
      rspec-support (~> 3.11.0)
    rspec-support (3.11.0)

PLATFORMS
  arm64-darwin-21
  java

DEPENDENCIES
  bundler-required_ruby_version-bug!
  rake (~> 13.0)
  rspec (~> 3.0)

BUNDLED WITH
   2.3.14
```

## Gemspecs

### bundler-required_ruby_version-bug.gemspec

```ruby
# frozen_string_literal: true

require_relative "lib/bundler/required_ruby_version/bug/version"

Gem::Specification.new do |spec|
  spec.name = "bundler-required_ruby_version-bug"
  spec.version = Bundler::RequiredRubyVersion::Bug::VERSION
  spec.authors = ["Peter Boling"]
  spec.email = ["peter.boling@gmail.com"]

  spec.summary = "Demonstrating a bug in bundler"
  spec.description = "Demonstrating a bug in bundler"
  spec.homepage = "https://github.com/rubocop-lts/bundler-required_ruby_version-bug"
  spec.license = "MIT"
  spec.required_ruby_version = ">= 2.4.0"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/rubocop-lts/bundler-required_ruby_version-bug"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(__dir__) do
    `git ls-files -z`.split("\x0").reject do |f|
      (f == __FILE__) || f.match(%r{\A(?:(?:bin|test|spec|features)/|\.(?:git|travis|circleci)|appveyor)})
    end
  end
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency("rubocop-lts", "~> 3.0")

  # For more information and examples about making a new gem, check out our
  # guide at: https://bundler.io/guides/creating_gem.html
end
```

--- TEMPLATE END ----------------------------------------------------------------

Unfortunately, an unexpected error occurred, and Bundler cannot continue.

First, try this link to see if there are any existing issue reports for this error:
https://github.com/rubygems/rubygems/search?q=undefined+method+%60name%27+for+nil+NilClass&type=Issues

If there aren't any reports for this error yet, please fill in the new issue form located at https://github.com/rubygems/rubygems/issues/new?labels=Bundler&template=bundler-related-issue.md, and copy and paste the report template above in there.
