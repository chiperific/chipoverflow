# frozen_string_literal: true

module ApplicationHelper
  def human_number(number, display_zero: false)
    integer = number.instance_of?(String) ? number.to_i : number

    return '-' if (integer.nil? || integer.zero?) && !display_zero

    number_with_delimiter(integer, delimiter: ',')
  end
end
