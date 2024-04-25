# Decisions

* Annotate gem

* Fix for Devise

## Annotate gem

Gem used to be able to write down all the attributes of a model in the file itself, with its characteristics. To run it you just have to run the following command: `bundle exec annotate`. But when you perform a migration it makes these notes automatically.

## Fix for Devise

There have been problems with the Devise implementation with the sessions, when authenticating JWTs. I leave the link [here](https://github.com/waiting-for-dev/devise-jwt/issues/235#issuecomment-1214414894). For this reason I had to put the `rack_session_fix.rb` concern.