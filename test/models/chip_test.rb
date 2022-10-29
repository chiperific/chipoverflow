# frozen_string_literal: true

require 'test_helper'

class ChipTest < ActiveSupport::TestCase
  context 'Chip.assign_record' do
    context 'when a Chip record' do
      context 'exists' do
        subject { Chip.assign_record }

        setup do
          Chip.assign_record
        end

        should 'set the Class to the first instance' do
          assert_equal Chip.all.size, 1

          assert_equal Chip.so_id, Chip.first.so_id
        end
      end

      context 'does not exist' do
        subject { Chip.assign_record }

        setup do
          # skips the before_destroy callback
          Chip.destroy_all
        end

        should 'Set the class to a newly created instance' do
          assert_equal Chip.all.size, 0

          Chip.assign_record

          assert_equal Chip.all.size, 1
          assert_equal Chip.so_id, Chip.first.so_id
        end
      end
    end
  end

  context 'instantiation' do
    setup do
      Chip.assign_record
    end

    should 'create public class methods to mirror instance attributes' do
      @instance = Chip.first
      keys = Chip.first.attributes.keys.map(&:to_sym)

      keys.each do |method|
        assert_respond_to Chip, method
      end
    end
  end

  context 'Chip.update' do
    setup do
      Chip.assign_record
    end

    should 'update the instance' do
      Chip.update(name: 'Minitest Name Update')

      assert_equal 'Minitest Name Update', Chip.name
      assert_equal 'Minitest Name Update', Chip.first.reload.name
    end
  end

  context 'Chip#highlander_clause' do
    context 'when no instances exist' do
      should 'allow the instance to be created' do
        assert_equal Chip.all.size, 0

        @instance = Chip.new

        assert_empty @instance.errors.messages

        @instance.save

        assert_empty @instance.reload.errors.messages
        assert_equal @instance.persisted?, true

        assert_equal Chip.all.size, 1

        assert_equal @instance.id, Chip.first.id
      end
    end

    context 'when an instance already exists' do
      setup do
        Chip.assign_record
      end

      should 'prevent the instance from being created' do
        assert_equal Chip.all.size, 1

        @instance = Chip.new

        assert_empty @instance.errors.messages
        assert_equal @instance.save, false
        assert_equal @instance.errors.size, 1
        assert_equal Chip.all.size, 1
      end
    end
  end
end
