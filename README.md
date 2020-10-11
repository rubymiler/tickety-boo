# Rails Support Ticket System with Meeting Schedule and Task Management

* Content management system for support tickets: including search, tagging, commenting, and FAQ features. 
* User authentication with Devise and Omniauth Google Oauth2.
* Authorization between regular and admin users using CanCanCan.
* User avatar and file upload through Active Storage and AWS S3.
* Admin users can schedule meetings and manage tasks for each support ticket.
* Email notifications on meeting schedule and updates through Action Mailer.
* Global success, warning, and error message rendering.
* Fully responsive front-end written in Sass.

## Demonstration

[Demo the project in production](https://tickety-boo.herokuapp.com/)

To test the app's admin functions, use the below demo account:
* email: zonia@stokes.biz
* password: remember

[Watch this video demo on how to use the app](https://youtu.be/boiLHpAFJIk)

[Read my blog post about Active Record Aliasing Association](https://medium.com/@lushiyun/using-aliasing-associations-for-intuitive-development-reflections-from-a-rails-project-faea6c66f9af)

[Check out my portfolio for my other projects](https://www.shiyunlu.com/)

## Getting Started

These instructions will get you a copy of the project up and running on your local machine for development and testing purposes.

### Prerequisites

Clone and run the following command inside this project's directory to load dependencies

    $ bundle

### Development

Run the following command to load database schema

    $ bundle exec rails db:setup

Start up local server

    $ bundle exec rails server

For interactive console

    $ bundle exec rails console

## Built With

* [Ruby 2.6.3](https://www.ruby-lang.org/en/news/2019/04/17/ruby-2-6-3-released/)
* [Rails 6.0.3](https://rubyonrails.org/) - Framework
* [Bundler](https://bundler.io/) - Dependency Management

## Contributing

Please read [CONTRIBUTING.md](https://gist.github.com/lushiyun/c8af9e2f2d6470468cfc37aa28f6edeb) for details on the code of conduct and the process for contributing.

## Versioning

Thie repository uses [SemVer](http://semver.org/) for versioning. For the versions available, see the [tags on this repository](https://github.com/lushiyun/sinatra-classmate-directory-app/tags). 

## Author

* **Shiyun Lu** - *Initial work* - [lushiyun](https://github.com/lushiyun)

## License

This project is licensed under the MIT License - see the [LICENSE.md](LICENSE.md) file for details