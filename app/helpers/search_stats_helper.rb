# frozen_string_literal: true

module SearchStatsHelper
  
  def selected_month
    if params[:date].nil? || params[:date][:month].nil?
      select_month(Date.today)
    else
      select_month(params[:date][:month].to_i)
    end
  end

end
