# Rails Support Ticket System with Meeting Schedule and Task Management

This is a class project built with Ruby on Rails for Flatiron School's software engineering program. It is a content management system for support tickets, including tagging, commenting, and frequently asked questions features. It provides user authorization for regular and admin users. Admin users can schedule meetings and establish as well as manage tasks in relation to support tickets. The project also supports ActionMailer for notifications on receiving of question responses, meeting invites, and task assignments. The front-end of the project, built with Sass, is fully responsive.

## Demonstration

[Demo the project in production](https://tickety-boo.herokuapp.com/)

To test the app's admin functions, use the below demo account:

* email: marc@okeefe-rippin.org

* password: remember


[Watch this video demo on how to use the app](https://youtu.be/5bk0_t-nwgg)


[Read my blog post about ActiveRecord Aliasing Association](https://medium.com/@lushiyun/using-aliasing-associations-for-intuitive-development-reflections-from-a-rails-project-faea6c66f9af)


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