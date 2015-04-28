#!/bin/zsh

bundle install

ruby ./download.rb
ruby ./convert.rb
ruby ./delete.rb
ruby ./upload.rb
