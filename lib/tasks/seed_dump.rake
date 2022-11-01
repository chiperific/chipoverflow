# frozen_string_literal: true

## =====> Hello, Interviewers!
#
# I wanted the comfort of writing these posts in a dev env
# And the convenience of not having to re-write them in prod
# Why use a gem when I can pick through a gem and hack together my own solution?
#
# The https://github.com/rroblak/seed_dump gem does have batching
# for memory management, but this app does not need to scale,
# 40 lines of code seems like a good arguement for not importing
# a gem and all its dependencies

namespace :db do
  namespace :seed do
    desc 'Dump records from the database into db/seeds.rb'
    task dump: :environment do
      Chipoverflow::Application.eager_load!

      tables = [
        Tag,
        Post,
        Comment,
        PostsTag
      ].freeze

      File.open('db/seeds.rb', 'w+') do |file|
        tables.each do |model|
          puts "== Writing #{model}:"
          model_record_size = model.count

          # skip models with no records
          next if model_record_size.zero?

          file.write(
            "#{model}.create!([\n"
          )

          model.all.each_with_index do |record, index|
            file.write "  #{record.for_seed}"
            file.write ",\n" unless (index + 1) == model_record_size
          end

          file.write(
            "\n])\n\n"
          )

          puts "==>>> #{model_record_size} records"
        end
      end
    end
  end
end
