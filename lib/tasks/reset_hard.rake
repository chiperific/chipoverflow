# frozen_string_literal: true

## =====> Hello, Interviewers!
#
# `rails db:setup` runs [db:create, db:schema:load, db:seed]
# `rails db:reset` runs [db:drop db:setup]
#
# for situations where I've edited an existing migration
# I want it all: [db:drop db:create db:migrate db:seed]
#
# and I sometimes want to dump the db into seeds before hand:
# [db:seed:dump db:drop db:create db:migrate db:seed]
namespace :db do
  namespace :reset do
    desc 'Drop, create, migrate (not schema:load) and seed'
    task hard: %w[db:drop db:create db:migrate db:seed]

    desc 'Dump seeds, then drop, create, migrate (not schema:load) and seed'
    task complete: %w[db:seed:dump db:drop db:create db:migrate db:seed]
  end
end
