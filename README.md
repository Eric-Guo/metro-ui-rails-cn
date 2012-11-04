# Metro UI for Rails 3.1 Asset Pipeline

This gem integrates [Metro-UI-CSS](https://github.com/olton/Metro-UI-CSS) toolkit into Rails 3.1 Asset Pipeline.

## Installation

Add this line to your application's Gemfile:

    gem 'metro-ui-rails-cn'

And then execute:

    $ bundle

## Installing to Rails project:

Require metro-ui/metro.less in your metro-ui-css-and-overrides.less

    @import 'metro-ui-css/modern.less';
    @import 'metro-ui-css/modern-responsive.less'; // for responsive design

Require metro-ui-css.less in your application.css:

    *= require metro-ui-css-and-overrides


And then require metro-ui in your js application file:

    //= require metro-ui-css-js


## Layout generator

You can generate Metro UI compatible .erb layout.

Usage:
    
    rails generate metro:layout [LAYOUT_NAME]

Example:

    rails generate metro:layout application

## Development

`git submodule init`  init git://github.com/olton/Metro-UI-CSS.git  
`git submodule update` update Metro-UI-CSS  
`rake update` update Metro-UI-CSS to gem
  

## License

This project only integrates [Metro-UI-CSS](https://github.com/olton/Metro-UI-CSS), 
thus all credits go to Sergey Pimenov, see his [license](https://github.com/olton/Metro-UI-CSS).
