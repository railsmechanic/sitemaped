# Sitemaped
Sitemaped is a powerful parser for XML sitemaps which respects all sitemaps listed in robots.txt and handles gziped and nested sitemaps as well.

## Features

- Respects sitemaps listed in robots.txt
- Handles gziped sitemaps
- Supports nested sitemaps (sitemap of sitemaps)

## Installation
### With Bundler
Just add to your Gemfile
~~~ruby
gem 'sitemaped'
~~~

### Without Bundler
If you're not using Bundler just execute on your commandline
~~~bash
$ gem install sitemaped
~~~

## Usage
### Get a list of all URLs listed in the sitemap
Sitemaped returns an array with all URLs listed in the sitemap(s)
~~~ruby
require 'sitemaped'

website = Sitemaped.new('http://www.example.com') # => ["http://www.example.com/", "http://www.example.com/contact", ...]
sitemap = website.sitemap
~~~

### Check whether an URL is covered by the sitemap
To check for an URL covered by the sitemap use
~~~ruby
require 'sitemaped'

sitemap = Sitemaped.new('http://www.example.com')
sitemap.include?('http://www.example.com/contact') # => true or false
~~~

## ToDo
- Search for optimizations
- Add tests