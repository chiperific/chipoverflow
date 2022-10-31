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
    { name: 'html' },
    { name: 'javascript' },
    { name: 'jquery' },
    { name: 'json' },
    { name: 'postgresql' },
    { name: 'rake' },
    { name: 'redis' },
    { name: 'rspec' },
    { name: 'ruby' },
    { name: 'ruby-on-rails' },
    { name: 'sidekiq' },
    { name: 'xml' }
  ]
)

Post.create(
  [
    {
      id: 1,
      title: "How did Chip learn to code? I don't see a CS degree on his resume.",
      body:
      "<div>\n<strong>TL;DR<br></strong><br>\n</div><ul>\n<li>2009: Chip got good a Microsoft Access while working for the Red Cross <strong><em> </em></strong>\n</li>\n<li>2010: Chip discovered Microsoft Visual Basic for Applications to extend Access and Excel functionality </li>\n<li>2011: Mark introduced Chip to Ruby on Rails</li>\n<li>2012: Chip cut his teeth on an inventory app for the Red Cross</li>\n<li>2015: Chip launched his first solo web app: a time management and tracking site for grant-based work for the Refugee Education Center</li>\n</ul><div>\n<br><strong>The long story:</strong><br>While at the American Red Cross, Chip submitted a project to the first-ever Grand Rapids GiveCamp event...</div>\n",
      rank: 1_667_076_693
    }
  ]
)
