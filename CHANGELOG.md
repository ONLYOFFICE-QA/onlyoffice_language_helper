# Change log

## master (unreleased)

## v0.3.0 (2020-11-22)

### New Features

* Run CI on `ruby-head`
* Add `dependabot` config
* Add `markdownlint` in CI
* Add `rubocop` check in CI
* Add 100% documentation check to CI
* Add `yard` development dependency

### Changes

* Use `GitHub Actions` instead of `Travis CI`
* Freeze all dependencies versions in Gemfile.lock
* Drop support of rubies older than 2.5
* Fix some warning from latest rubocop
* Add all missing documentation
* More strict dependencies version for some
* Move repo to `ONLYOFFICE-QA` organization

## v0.2.0 (2020-05-14)

### New Features

* Add support of `rubocop-rspec`
* Add rake task to release gem to github

### Fixes

* Fix coverage report on non-CI environments

### Refactor

* Remove unused `detect_lang_via_whatlanguage` method
* Extract `Config` to separate file
* Extract `DictionariesThreads` to separate file
* Remove `ActiveSupport` as dependency
* Rename `Detect_Language` to `DetectLanguageWrapper`
* Actualize `gemspec` file
