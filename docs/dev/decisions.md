# Decisions

* Annotate gem

* Fix for Devise

* Rspec

* Factory Bot

* Simplecov

* I18n

## Annotate gem

Gem used to be able to write down all the attributes of a model in the file itself, with its characteristics. To run it you just have to run the following command: `bundle exec annotate`. But when you perform a migration it makes these notes automatically.

## Fix for Devise

There have been problems with the Devise implementation with the sessions, when authenticating JWTs. I leave the link [here](https://github.com/waiting-for-dev/devise-jwt/issues/235#issuecomment-1214414894). For this reason I had to put the `rack_session_fix.rb` concern.

## Rspec

The Rspec gem is used to be able to run the entire set of tests that we carry out to verify that our environment is safe and to be able to see all the cases that may occur in our API

## Factory Bot

Factory Bot helps us generate models with test data without having to create them again and again in each file. We only define the model with the data we want and we can call it directly from the tests to create that model automatically.

## Simplecov

Gem that allows us to see what percentage of code we have tested. Simply by running the tests as always, we will get the result in the end.

## I18n

The I18n library has been added, since it helps a lot with error control and handling it by code and for future translations if necessary.