#!/bin/sh
rm gemfile.lock
bundle install
rake test
rail server -p 8080
true
