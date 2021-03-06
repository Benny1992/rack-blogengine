# Rack::Blogengine

Rack Application to serve a simple blog

## NOTE

This is just a project for learning purpose, but if you want to use it read further.
Code should be considered bad (1st ruby project).
Also its not actively maintained.

## Build status

[![Gem Version](https://badge.fury.io/rb/rack-blogengine.png)](http://badge.fury.io/rb/rack-blogengine)
[![Build Status](https://travis-ci.org/tak1n/rack-blogengine.svg?branch=master)](https://travis-ci.org/tak1n/rack-blogengine)
[![Code Climate](https://codeclimate.com/github/tak1n/rack-blogengine/badges/gpa.svg)](https://codeclimate.com/github/tak1n/rack-blogengine)
[![Test Coverage](https://codeclimate.com/github/tak1n/rack-blogengine/badges/coverage.svg)](https://codeclimate.com/github/tak1n/rack-blogengine/coverage)
[![Inline docs](http://inch-ci.org/github/tak1n/rack-blogengine.svg?branch=master)](http://inch-ci.org/github/tak1n/rack-blogengine)
[![Dependency Status](https://gemnasium.com/Benny1992/rack-blogengine.png)](https://gemnasium.com/Benny1992/rack-blogengine)

## Supported Ruby Versions & Platforms

- rbx  > 3.14
- ruby > 2.2



## Installation

    $ gem install rack-blogengine

## Usage

`rack-blogengine generate <folder>` will create your Folder skeleton

### Structure

These folders and files will be created for you

#### Folders
`targetfolder/assets`

`targetfolder/assets/style`

`targetfolder/assets/js`

`targetfolder/assets/layout`

`targetfolder/assets/images`

`targetfolder/operator`

#### Files
`targetfolder/assets/style/style.css`

`targetfolder/assets/js/script.js`

`targetfolder/assets/layout/layout.html` (filled with basic structure)

`targetfolder/index.content` (filled with dummy content)

`targetfolder/config.yml` (basic config setup - server: webrick, port: 3000)

`targetfolder/operator/operator.rb` (define your operator methods in module UserOperator)

### Layout

In the layout.html you use {title}, {content} and {date} which will then be populated with the values from each .content file
Example:
```html
<!DOCTYPE html>
<html>
	<head>
		<title>{title}</title>
	</head>
	<body>
		<h1>{title}</h1>
		<div>
			{date}
			{content}
		</div>
	</body>
</html>
```
### Content

The Content files (.content) includes your content

`[path][/path]` - this will be your access path to your blog entry

`[title][/title]` - the title for your article

`[date][/date]` - publishing date of your article

`[content][/content]` - your content

### Hint
For a root document (http://pathtoapp.tld/) path should be empty ([path]:[/path])

### Operators

In version 0.1.2 operator handling is included.
To use this new feature you have to create a operator directory in your rackblog folder.
In this directory create your operators (.rb files) with following skeleton

```ruby
module UserOperator
end
```

Your operators are normal ruby methods defined in this module.
Available params are documents & html

Param documents:
An Array with document objects.
This Document objects has following attributes: path, title, html

Param html:
The content of the file where the operator was included

#### Example

```ruby
module UserOperator
  def show_nav
  end
end
```

In your layout.html then

```html
<div class="nav">
	{% show_nav %}
</div>
```

## TODO

Implement pygments without nokogiri html parser (maybe use oga as alternative - <a href="https://github.com/YorickPeterse/oga">https://github.com/YorickPeterse/oga</a>)

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request









