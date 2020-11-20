# Change log

## master (unreleased)

### New Features

* Run CI on `ruby-head`
* Add `dependabot` config

### Changes

* Use `GitHub Actions` instead of `Travis CI`
* Freeze all dependencies versions in Gemfile.lock
* Drop support of rubies older than 2.5

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
