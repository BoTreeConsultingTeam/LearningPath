class ChartsController < ApplicationController

  before_filter :get_date
  # before_filter :google_chart_init

  def chart_by_learn
    data_table = GoogleVisualr::DataTable.new
    data_table.new_column('date', 'Day')
    data_table.new_column('number', 'Learn Count')
    data_table.new_column('number', 'Add Count')

    @chart_by_learn = LearnTime.report_of_learn_time(current_user.id, @date)
    @total_links = current_user.total_links_after(@date)

    all = ((Date.today-30)..Date.today).inject([]) do |all, date |
      learn_count = @chart_by_learn[date] || 0
      link_count = @total_links[date] || 0

      all << [date, learn_count, link_count ]
    end

    data_table.add_rows(all)
    learn_opts   = { :width => 450, :height => 400, :title => '', :legend => 'bottom' }
    @chart = GoogleVisualr::Interactive::LineChart.new(data_table, learn_opts)

    tags_question_data = GoogleVisualr::DataTable.new
    tags_question_data.new_column('string', 'Tag')
    tags_question_data.new_column('number', 'Tag Count')

    @tags = ActsAsTaggableOn::Tag.all
    tags_usage_data = @tags.map{|tag|[ tag.name, Link.where(:user_id => current_user.id).tagged_with(tag).count]}
    tags_question_data.add_rows(tags_usage_data.sort {|a,b| a[1] <=> b[1]}.reverse.first(10))
    tag_opts   = { :width => 450, :height => 400, :title => '', :legend => 'bottom' }
    @tag_chart = GoogleVisualr::Interactive::PieChart.new(tags_question_data, tag_opts)

  end

  private

    def get_date
      start_date = params[:start_date] || Date.today
      @days = params[:days] ? params[:days] : 30
      @date = start_date - @days
    end

end
