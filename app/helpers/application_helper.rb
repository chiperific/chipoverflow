# frozen_string_literal: true

module ApplicationHelper
  def human_number(number, display_zero: false)
    integer = number.instance_of?(String) ? number.to_i : number

    return '-' if (integer.nil? || integer.zero?) && !display_zero

    number_with_delimiter(integer, delimiter: ',')
  end

  def human_time(time, local: true)
    return '-' unless [Time, ActiveSupport::TimeWithZone].include? time.class

    time = time.localtime if local

    # "Oct 20 at 18:19"
    time.strftime('%b %-d at %k:%M')
  end
end
