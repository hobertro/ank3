# Ank3

Ank3 is a simple command line interface (CLI) to create text files that can be ingested by Anki to create Anki cards.
Alternatively, you can generate a boilerplate YAML file where you can create cards with a front, back, and tags.

## Motivation and Anki work flow

I personally use Anki to review anything that I study. I don't always have the app available
nor do I want to always use the app to create new cards. Sometimes I want to review the questions/answers
of the cards because I actually create them, so I put them in a separate text file where I copy and paste
to questions and answers to Anki when I'm ready to create the cards. This procedure is too manual, so I
thought I would try to automate it by creating this gem.

You might ask why not just create the simple Anki text file? 
The reason is because I would like to use the YAML files for other purposes, such 
as storing or parsing it as notes. 

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'ank3'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install ank3

## Usage

To parse a YAML file to a Anki .txt file, simply run:

```./ank3 covert [FILE.yml]``` in the command line.

Example:

Using a YAML file that looks like:

```yaml
---
- front: 'What is 1+1?'
  back: 'Two'
  tags: []
---
- front: 'What is H20?'
  back: 'Water'
  tags: []
```

will generate a .txt file that looks like:

```
# Anki .txt file format that represents a card with front and back
What is 1+1?; Two
What is H2O?; Water
```

To generate a boilerplate file, simply run:

```./ank3 generate_boilerplate [number of cards]``` and it will generate a YAML file containing an array with [number of cards] of hashes.

For example:

```./ank3 generate_boilerplate 3``` will generate a YAML file with 3 hashes, each representing a card looking like this:

```yaml
---
- front: ''
  back: ''
  tags: []
- front: ''
  back: ''
  tags: []
- front: ''
  back: ''
  tags: []
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. 

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/ank3. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Ank3 project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/ank3/blob/master/CODE_OF_CONDUCT.md).
