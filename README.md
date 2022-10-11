# SimpleCV

SimpleCV creates beautiful CVs simple and fast with just a config file! Example configuration files can be found in examples folder.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'simple_cv'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install simple_cv

## Usage

```ruby
cv = SimpleCV::Basic.new(config_path: "path/to/config_file.json")

# Will render file to current location
cv.render_file

# Will render file to a specific location with a specific filename
cv.render_file(path: "path/to/output", filename: "file")
```

## Development

To build initial container run:

```
make build
```

To start container in development mode:

```
make dev
```

To run tests:

```
make tests
```

Further planned functionalities:

- Different layout templates

## Contributing

Bug reports and pull requests are welcome on GitHub at [https://github.com/freder1c/simple_cv](https://github.com/freder1c/simple_cv).

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
