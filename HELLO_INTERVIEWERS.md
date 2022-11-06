# Here's some code I'd like you to see:

### chipoverflow

#### HTML scraping
Using Net:HTTP and Nokogiri to get data from my SO profile
https://github.com/chiperific/chipoverflow/tree/main/app/jobs/update_reputation_job.rb#L6

#### Faking identicons from Gravitar
https://github.com/chiperific/chipoverflow/tree/main/app/models/author.rb#L9

#### Metaprogramming butchery
Classes are proper nouns, class instances aren't
https://github.com/chiperific/chipoverflow/tree/main/app/models/chip.rb#L3


#### Stimulus + Turbo = new DOM items on demand
https://github.com/chiperific/chipoverflow/tree/main/app/views/application/sign_in.haml#L51

#### Optional URL components in routes
https://github.com/chiperific/chipoverflow/tree/main/config/routes.rb#L29

#### Rake extensions on db: tasks
`rake db:reset:hard && rake db:reset:complete`
https://github.com/chiperific/chipoverflow/tree/main/lib/tasks/reset_hard.rake#L3

`rake db:seed:dump`
https://github.com/chiperific/chipoverflow/tree/main/lib/tasks/seed_dump.rake#L3


### filterbuildscheduler

#### Inventory logic
##### Extrapolation
https://github.com/chiperific/filterbuildscheduler/tree/master/app/jobs/event_inventory_job.rb
https://github.com/chiperific/filterbuildscheduler/tree/master/app/jobs/extrapolate_inventory_job.rb

##### Calculation
https://github.com/chiperific/filterbuildscheduler/tree/master/app/jobs/price_calculation_job.rb
https://github.com/chiperific/filterbuildscheduler/tree/master/app/jobs/produceable_job.rb
https://github.com/chiperific/filterbuildscheduler/tree/master/app/jobs/quantity_and_depth_calculation_job.rb

#### Model flexing
Assembly: polymorphic and tree-like
https://github.com/chiperific/filterbuildscheduler/tree/master/app/models/assembly.rb

Multi-model searching
https://github.com/chiperific/filterbuildscheduler/tree/master/app/assets/javascripts/controllers/combinations.js#L6
https://github.com/chiperific/filterbuildscheduler/tree/master/app/views/assemblies/_new_form.haml

Concern: Itemable
https://github.com/chiperific/filterbuildscheduler/tree/master/app/models/concerns/itemable.rb

#### Websockets
Multi-user inventory view with auto-updates
app/assets/javascripts/channels/counts_channel.js

#### Metaprogramming
`String.objectify_uid`
https://github.com/chiperific/filterbuildscheduler/tree/master/lib/core_ext/string.rb
https://github.com/chiperific/filterbuildscheduler/tree/master/config/routes.rb#L24

Spec Generator
https://github.com/chiperific/filterbuildscheduler/tree/master/lib/generators/spec/spec_generator.rb

##### Stripe payment webhook
https://github.com/chiperific/filterbuildscheduler/tree/master/app/controllers/webhooks_controller.rb

#### Jobs and Services
https://github.com/chiperific/filterbuildscheduler/tree/master/app/models/email.rb
https://github.com/chiperific/filterbuildscheduler/tree/master/app/jobs/email_sync_job.rb
https://github.com/chiperific/filterbuildscheduler/tree/master/app/services/gmail_client.rb
https://github.com/chiperific/filterbuildscheduler/tree/master/app/services/kindful_client.rb

#### Minor flexes
SQL
https://github.com/chiperific/filterbuildscheduler/tree/master/app/models/component.rb#L57

RailsAdmin customization
https://github.com/chiperific/filterbuildscheduler/tree/master/app/assets/javascripts/rails_admin/custom/rails_admin_global.js#L21

Limit JS functions to the view in question
https://github.com/chiperific/filterbuildscheduler/tree/master/app/assets/javascripts/application.js#L31

JS DOM element sizing
https://github.com/chiperific/filterbuildscheduler/tree/master/app/assets/javascripts/controllers/hero.js


### liters_tracker


### promisetasks
