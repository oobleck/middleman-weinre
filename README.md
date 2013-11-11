Middleman Weinre
------------------

A simple extension to start the [Weinre](http://people.apache.org/~pmuellr/weinre/docs/latest/) server and a helper method to inject the script tag in your template/layout.

## Requirements
 - [Middleman](http://www.middlemanapp.com) 3.0.0+
 - [Weinre](http://people.apache.org/~pmuellr/weinre/docs/latest/)

## Installation

Add this to your Middleman project's Gemfile

```ruby
gem "middleman-weinre"
```
and run

```bash
$ bundle install
```

## Usage
Activate the extension in your `config.rb` file:

```ruby
activate :weinre
```

### Config examples
```erb
activate :weinre,
  :hostname => "localhost",
  :port => 8080,
  :bin => "/usr/local/bin/weinre"
```

### Template helpers

You can insert the [Weinre](http://people.apache.org/~pmuellr/weinre/docs/latest/) javascript tag in your template or layout with

```ruby
<%= weinre_include_tag %>
```

## Options

###### `:hostname`  _(default: nil)_

Hostname to inject if not using the default of "localhost"

###### `:port`  _(default: 8080)_

The port to setup Weinre on when running the server and injecting the tag.

###### `:bin`  _(default: "/usr/local/bin/weinre")_

THe local path to the weinre bin

## ToDo

 - Auto inject script tag at end of layout
