## [1.0.3] - 2025-08-24

- By default, strip Set-Cookie headers out of VCR cassettes

## [1.0.2] - 2025-08-24

- Restore generating bin/console since it powers `foob c`

## [1.0.1] - 2025-08-22

- Remove bin/ files generation

## [1.0.0] - 2025-07-09

- Simplify MINIMUM_RUBY_VERSION
- Make generated version boundaries more future-proof

## [0.0.23] - 2025-05-07

- Bump deps in templates
- Improve CHANGELOG.md template

## [0.0.22] - 2025-05-07

- Do not stop just because rubocop fails

## [0.0.21] - 2025-05-03

- Make optional things fail-safe when shelling out and simplify the code a bit, too

## [0.0.20] - 2025-05-03

- Add use_git, push_to_github, and turn_on_rbenv_bundler options and default them to false

## [0.0.19] - 2025-05-03

- Do not fail just because gh isn't installed

## [0.0.18] - 2025-04-23

- Improve interface a bit to be more intuitive re: extracting code from another repo

## [0.0.17] - 2025-04-15

- Fix bug preventing rubocop from running if it's not available in the outer environment

## [0.0.16] - 2025-04-15

- Fix bug when FileUtils isn't already required by other gems
- Support new ExtractRepo interface

## [0.0.15] - 2025-04-08

- Improve generated README.md

## [0.0.14] - 2025-02-19

- Bump Ruby to 3.4.2
- Write the current ruby version to .ruby-version.erb instead of a hard-coded value
- Fix irb gem deprecation warnings
- Add MINIMUM_RUBY_VERSION to version.rb.erb and use it in .gemspec.erb and Gemfile.erb

## [0.0.13] - 2025-01-03

- Bump to Ruby 3.4.1
- Fix various bugs resulting in incorrect license information

## [0.0.12] - 2024-12-16

- Fix bug preventing setting origin remote and pushing initial comit to github

## [0.0.11] - 2024-11-30

- Fix initial module naming bug

## [0.0.10] - 2024-11-14

- Create an empty module

## [0.0.9] - 2024-11-13

- Allow choosing different licenses: MIT, Apache-2.0, MPL-2.0, Apache-2.0 OR MIT, none

## [0.0.8] - 2024-11-07

- Add ability to extract code and git history from one repository into the new project

## [0.0.7] - 2024-11-01

- Do not automatically push to github via gh

## [0.0.5] - 2024-07-08

- Remove unnecessary foobara gem wiring up code from templates/.github

## [0.0.4] - 2024-07-04

- Remove unnecessary foobara gem wiring up code from templates/.github

## [0.0.3] - 2024-06-23

- Remove a bunch of unnecessary gems from templates/Gemfile

## [0.0.2] - 2024-06-19

- Add missing templates to gem
- Don't assume Bundle is loaded

## [0.0.1] - 2024-06-17

- Add Apache-2.0 license

## [0.0.0] - 2024-02-20

- Project birth
