# TLC Directory

[![CircleCI](https://circleci.com/gh/wvulibraries/TLC-Directory.svg?style=svg)](https://circleci.com/gh/wvulibraries/TLC-Directory) [![Maintainability](https://api.codeclimate.com/v1/badges/1eec8b064ca2d1e6a761/maintainability)](https://codeclimate.com/github/wvulibraries/TLC-Directory/maintainability) [![Test Coverage](https://api.codeclimate.com/v1/badges/1eec8b064ca2d1e6a761/test_coverage)](https://codeclimate.com/github/wvulibraries/TLC-Directory/test_coverage)

The TLC directory application will replace the current static pdf that is currently is use.

## Versions
- Rails 5.2.4
- Ruby  2.6.0
- ElasticSearch 7.5.0
- MySQL 5.7.27

## Testing and Quality Control 
The test suite includes rspec, capybara, selnium, simplecov, CircleCI, and code climate. Javascript is difficult to test by itself. To run tests locally uncomment the selenium docker container and adjust capybara setups. RAILS_ENV=test bundle exec rspec this helps to ensure that all gems are loaded appropriately and you do not get the shoulda error.

# Elastics Search 
Elastic search is responsible for the searching and indexing of the Rails data. Using callbacks the data will be adjusted and indexed everytime an action is made on the dataset.  In the event that you have to reindex again, you may want to use the rake tasks written in the lib folder, not the ones from the default library.  If a model is not enabled it will show up in the search using the default rake tasks associated with the Rails Elastic Search Gems.  

## Rake Tasks

```
rake search_index:all                              # Re-index all environments
rake search_index:college                          # Properly Index College
rake search_index:department                       # Properly Index Departments
rake search_index:faculty                          # Properly Index Faculty
```
