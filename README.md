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

Further planned functionalities:

- Dynamin layout calculations depending on content for better look
- More icons for contact topics
- Dynamic calculation for size of skill bars depending on skill name lengths
- Display page count, when experience / education section reaches second page
- Different layout templates

## Contributing

Bug reports and pull requests are welcome on GitHub at [https://github.com/freder1c/simple_cv](https://github.com/freder1c/simple_cv).

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

Mail Icon made by [Freepik](http://www.freepik.com) from [www.flaticon.com](www.flaticon.com)  
Location Icon made by [Freepik](http://www.freepik.com) from [www.flaticon.com](www.flaticon.com)  
Globe made by [Designerz Base](http://www.finest.graphics) from [www.flaticon.com](www.flaticon.com)  
Phone made by [Freepik](http://www.freepik.com) from [www.flaticon.com](www.flaticon.com)
