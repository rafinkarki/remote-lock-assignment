# frozen_string_literal: true

require 'date'
class PeopleController
  def initialize(params)
    @params = params
  end

  def normalize
    @people = Hash.new(0)
    @dollor_format = @params[:dollar_format].split("\n")
    @percent_format = @params[:percent_format].split("\n")

    format_people_with_dollar
    format_people_with_percentage

    @people.sort.map { |_k, v| v }
  end

  def format_people_with_dollar
    @dollor_format.drop(1).each do |dollar_row|
      row_data = dollar_row.split(' $ ')
      detail = [row_data.last, actual_location(row_data.first), format_date(row_data[1], '%d-%m-%Y')]
      @people[row_data.last] = detail.join(', ').to_s
    end
  end

  def format_people_with_percentage
    @percent_format.drop(1).each do |percent_row|
      row_data = percent_row.split(' % ')
      detail = [row_data.first, actual_location(row_data[1]), format_date(row_data.last, '%Y-%m-%d')]
      @people[row_data.first] = detail.join(', ').to_s
    end
  end

  def format_date(date, format)
    date_obj = DateTime.strptime(date, format)
    date_obj.strftime('%-m/%-d/%Y')
  end

  def actual_location(abbr_loc)
    if abbr_loc == 'LA'
      'Los Angeles'
    elsif abbr_loc == 'NYC'
      'New York City'
    else
      abbr_loc
    end
  end

  private

  attr_reader :params
end
