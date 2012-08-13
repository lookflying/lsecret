class StatController < ApplicationController
  def average
    calc_month
    @month_average = {}
    @month_average[:income] = @income_sum / @month_income.size
    @month_average[:expense] = @expense_sum / @month_expense.size
  end

  def trend
  end

  def zui
    
  end
  
  def stat
    calc_month  
    
  end
  def calc_month
    @oldest = Record.minimum(:day)
    @latest = Record.maximum(:day)
    @month_income = {}
    @month_expense = {}
    @month_balance = {}
    month = @oldest.beginning_of_month
    last = @latest.beginning_of_month
    @income_sum = @expense_sum = 0;
    @years = []
    while month <= last do
      this_month = Record.where("day >= ? AND day < ?", month, month.next_month)
      @month_income[month]  = this_month.sum(:income)
      @month_expense[month] = this_month.sum(:expense)
      @month_balance[month] = @month_income[month] - @month_expense[month]
      @income_sum += @month_income[month]
      @expense_sum += @month_expense[month]
      if !@years.include? month.year
        @years << month.year
      end
      month = month.next_month
    end
  end
  
end
