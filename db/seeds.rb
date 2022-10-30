# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
Tag.create(
  [
    { name: 'api' },
    { name: 'actioncontroller' },
    { name: 'actionmailer' },
    { name: 'actiontext' },
    { name: 'activerecord' },
    { name: 'ajax' },
    { name: 'association' },
    { name: 'authentication' },
    { name: 'capybara' },
    { name: 'coffeescript' },
    { name: 'config' },
    { name: 'css' },
    { name: 'database-design' },
    { name: 'database-schema' },
    { name: 'datatable' },
    { name: 'devise' },
    { name: 'gmail-api' },
    { name: 'google-api' },
    { name: 'javascript' },
    { name: 'jquery' },
    { name: 'json' },
    { name: 'postgresql' },
    { name: 'rake' },
    { name: 'redis' },
    { name: 'rspec' },
    { name: 'ruby' },
    { name: 'ruby-on-rails' },
    { name: 'sidekiq' }
  ]
)
