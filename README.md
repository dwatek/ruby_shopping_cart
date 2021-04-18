# RubyShoppingCart

To experiment with that code, run `bin/console` for an interactive prompt.

## Setup

Run docker from the main repository's root directory. It starts containers with postgresql server:

```bash
$ docker-compose up -d
```

From project's root directory run commands:

```bash
$ bundle install
```

Prepare development database and run migrations:

```bash
$ bundle exec rake db:create
$ bundle exec rake db:migrate
$ bundle exec rake db:seed
```

## Usage

The interface to the checkout looks like this (shown in Ruby):

```
co = Checkout.new(promotional_rules)
co.scan(item)
co.scan(item)
price = co.total
```