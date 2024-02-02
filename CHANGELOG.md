# Change log

## master (unreleased)

### New Features

* Add `ruby-3.2` in CI
* Add `ruby-3.3` to CI
* Add `dependabot` check for `GitHub Actions`

### Fixes

* Fix incorrect gem license name
* Fix warning about homepage gem metadata
* Fix gem build warning about `httparty` gem version

### Changes

* Drop support of `ruby-2.7`, since it's EOLed
* Migrate coverage report to `codecov v4`

## v0.5.0 (2022-08-17)

### New Features

* Add `yamllint` support in CI
* Add `ruby-3.0` and `ruby-3.1` in CI

### Changes

* Require `mfa` for releasing gem
* Actualize `nodejs` version in CI
* Remove `codeclimate` config since we do not use it any more
* Change `dependabot` config to check at 8AM MSK
* Fix ruby version usage in CI
* Changes from `rubocop-rspec` update to 2.9.0
* Fix `rubocop-1.28.1` code issues
* Drop `ruby-2.6` support since it's EOL'ed

## v0.4.0 (2021-07-01)

### New Features

* Add `rubocop-rake` support

### Changes

* **Major Change** Use `ffi-hunspell` instead of `hunspell-ffi`

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
