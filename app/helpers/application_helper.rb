# frozen_string_literal: true

module ApplicationHelper
  def human_number(number, display_zero: false)
    integer = number.instance_of?(String) ? number.to_i : number

    return '-' if (integer.nil? || integer.zero?) && !display_zero

    number_with_delimiter(integer, delimiter: ',')
  end

  def human_time(time, local: true, year: false)
    return '-' unless [Time, ActiveSupport::TimeWithZone].include? time.class

    time = time.localtime if local

    # "Oct 20 at 18:19"
    return time.strftime('%b %-d at %k:%M') unless year

    # "Oct 20, 2022 at 18:19"
    time.strftime('%b %-d, %Y at %k:%M')
  end

  def session_info_for(klass_id, klass)
    hsh = {}

    hsh[:upvoted] = session_has_record(klass_id, 'upvoted', klass)

    case klass
    when 'posts'
      hsh[:downvoted] = session_has_record(klass_id, 'downvoted', klass)
      hsh[:bookmarked] = session_has_record(klass_id, 'bookmarked', klass)
    when 'comments'
      hsh[:flagged] = session_has_record(klass_id, 'flagged', klass)
    end

    hsh
  end

  def session_has_record(post_id, state_name, klass)
    records = session.dig(klass, state_name)

    return false if records.nil?

    records.include? post_id
  end
end
