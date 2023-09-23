# Here's some code I'd like you to see:

## chipoverflow

1. __HTML scraping__

    Using Net:HTTP and Nokogiri
    - https://github.com/chiperific/chipoverflow/blob/main/app/jobs/update_reputation_job.rb#L6

2. __Faking identicons from Gravitar__
    - https://github.com/chiperific/chipoverflow/blob/main/app/models/author.rb#L9

3. __Metaprogramming butchery__

    Because classes are proper nouns and class instances aren't
    - https://github.com/chiperific/chipoverflow/blob/main/app/models/chip.rb#L3

4. __Stimulus + Turbo = DOM manipluation on demand__

    Realtime search (TurboStreams)
    - https://github.com/chiperific/chipoverflow/blob/main/app/controllers/tags_controller.rb#L21

    Add a DOM element on click (TurboDrive and Stimulus)
    - https://github.com/chiperific/chipoverflow/blob/main/app/views/application/sign_in.haml#L51

5. __Optional URL components in routes__
    - https://github.com/chiperific/chipoverflow/blob/main/config/routes.rb#L48

6. __Rake extensions on db: tasks__

    `rake db:reset:hard && rake db:reset:complete`
    - https://github.com/chiperific/chipoverflow/blob/main/lib/tasks/reset_hard.rake#L3

    `rake db:seed:dump`
    - https://github.com/chiperific/chipoverflow/blob/main/lib/tasks/seed_dump.rake#L3



## filterbuildscheduler

1. __Inventory logic__

    Extrapolation
    - https://github.com/20LitersAdmin/filterbuildscheduler/blob/master/app/jobs/event_inventory_job.rb
    - https://github.com/20LitersAdmin/filterbuildscheduler/blob/master/app/jobs/extrapolate_inventory_job.rb

    Calculation
    - https://github.com/20LitersAdmin/filterbuildscheduler/blob/master/app/jobs/price_calculation_job.rb
    - https://github.com/20LitersAdmin/filterbuildscheduler/blob/master/app/jobs/produceable_job.rb
    - https://github.com/20LitersAdmin/filterbuildscheduler/blob/master/app/jobs/quantity_and_depth_calculation_job.rb

1. __Model flexing__

    Assembly: polymorphic and tree-like
    - https://github.com/20LitersAdmin/filterbuildscheduler/blob/master/app/models/assembly.rb

    Multi-model searching
    - https://github.com/20LitersAdmin/filterbuildscheduler/blob/master/app/assets/javascripts/controllers/combinations.js#L6
    - https://github.com/20LitersAdmin/filterbuildscheduler/blob/master/app/views/assemblies/_new_form.haml

    Concern: Itemable
    - https://github.com/20LitersAdmin/filterbuildscheduler/blob/master/app/models/concerns/itemable.rb

1. __Websockets__

    Multi-user inventory view with auto-updates
    - https://github.com/20LitersAdmin/filterbuildscheduler/blob/master/app/assets/javascripts/channels/counts_channel.js

1. __Metaprogramming__

    `String.objectify_uid`
    - https://github.com/20LitersAdmin/filterbuildscheduler/blob/master/lib/core_ext/string.rb
    - https://github.com/20LitersAdmin/filterbuildscheduler/blob/master/config/routes.rb#L24

    Spec Generator
    - https://github.com/20LitersAdmin/filterbuildscheduler/blob/master/lib/generators/spec/spec_generator.rb

1. __Stripe payment webhook__

    - https://github.com/20LitersAdmin/filterbuildscheduler/blob/master/app/controllers/webhooks_controller.rb

1. __Jobs and Services__

    - https://github.com/20LitersAdmin/filterbuildscheduler/blob/master/app/models/email.rb
    - https://github.com/20LitersAdmin/filterbuildscheduler/blob/master/app/jobs/email_sync_job.rb
    - https://github.com/20LitersAdmin/filterbuildscheduler/blob/master/app/services/gmail_client.rb
    - https://github.com/20LitersAdmin/filterbuildscheduler/blob/master/app/services/kindful_client.rb

1. __Minor flexes__

    SQL
    - https://github.com/20LitersAdmin/filterbuildscheduler/blob/master/app/models/component.rb#L57

    RailsAdmin customization
    - https://github.com/20LitersAdmin/filterbuildscheduler/blob/master/app/assets/javascripts/rails_admin/custom/rails_admin_global.js#L21

    Limit JS functions to the view in question
    - https://github.com/20LitersAdmin/filterbuildscheduler/blob/master/app/assets/javascripts/application.js#L31

    JS DOM element sizing
    - https://github.com/20LitersAdmin/filterbuildscheduler/blob/master/app/assets/javascripts/controllers/hero.js



## liters_tracker

1. __`redirect_back` patching__

    Rails' `redirect_back` is embarassingly bad. I try to make it slightly less so.
    - https://github.com/20LitersAdmin/liters_tracker/blob/master/app/controllers/application_controller.rb#L9

1. __`rake` task for database copying from production to development__

    Similar to Thoughbot's Parity, but for Railway
    - https://github.com/20LitersAdmin/liters_tracker/blob/master/lib/tasks/db.rake

1. __Fat model, skinny controller__

    ActiveStorage and Imagemagick processing
    - https://github.com/20LitersAdmin/liters_tracker/blob/master/app/models/story.rb#L44

    Complex method for finding related records with use of session storage
    - https://github.com/20LitersAdmin/liters_tracker/blob/master/app/models/story.rb#L75

1. __Using JSONB to simplify tree-like relationships__

    - https://github.com/20LitersAdmin/liters_tracker/blob/master/app/services/hierarchy_reset_service.rb



## promisetasks

Just an app I'm proud of. It's small, narrow in scope, and does what it says on the tin, or rather, the README

- https://github.com/chiperific/promistasks/blob/master/README.md
