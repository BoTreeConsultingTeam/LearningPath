class ChartsController < ApplicationController

  before_filter :get_date
  # before_filter :google_chart_init

  def chart_by_learn

    data_table = GoogleVisualr::DataTable.new
    data_table.new_column('date', 'Day')
    data_table.new_column('number', 'Learn_Count')
    data_table.new_column('number', 'Add_Count')

    @chart_by_learn = LearnTime.report_of_learn_time(current_user.id, @date)
    @total_links = User.get_all_link(current_user, @date)

    all = ((Date.today-30)..Date.today).inject([]) do |all, date |
      learn_count = @chart_by_learn[date] || 0
      link_count = @total_links[date] || 0

      all << [date, learn_count, link_count ]
    end

    data_table.add_rows(all)
    opts   = { :width => 500, :height => 440, :title => 'Learning Growth', :legend => 'bottom' }
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
