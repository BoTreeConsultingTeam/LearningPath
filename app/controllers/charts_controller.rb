class ChartsController < ApplicationController

  before_filter :get_date
  # before_filter :google_chart_init

  def chart_by_learn

    data_table = GoogleVisualr::DataTable.new
    data_table.new_column('number', 'D')
    data_table.new_column('number', 'Learn_Count')
    data_table.new_column('number', 'Add_Count')
    # data_table.add_rows(5)

    @chart_by_learn = LearnTime.report_of_lern_time(current_user.id, @date)
    @count = @chart_by_learn.values.map {|v| v.size}.max
    @total_links = Links.
    data_array = Array.new

    @chart_by_learn.to_a.reverse.each_with_index do |data, index|
      data_array << [data.first.day, data.last.count]
      # data_table.set_cell(index, 0, data.first.day)
      # data_table.set_cell(index, 1, data.last.count)
    end
    data_table.add_rows(data_array)
    opts   = { :width => 400, :height => 240, :title => 'Learning Growth', :legend => 'bottom' }
    @chart = GoogleVisualr::Interactive::LineChart.new(data_table, opts)

  end

  def chart_by_tag

  end

  private

    def get_date
      start_date = params[:start_date] || Date.today
      @days = params[:days] ? params[:days] : 30
      @date = start_date - @days
    end

end
