# frozen_string_literal: true

namespace :db do
  namespace :seed do
    desc 'Dump records from the database into db/seeds/*.yml'
    task dump: :environment do
      require Rails.root.join('db/seeds/exporter')

      Seeds::Exporter.new.call
      puts 'Seed YAML exported.'
    end
  end
end
