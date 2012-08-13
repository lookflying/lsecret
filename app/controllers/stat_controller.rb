class StatController < ApplicationController
  def average
    calc_month
   
  end

  def trend
    calc_month
    @month_increment = @month_average[:income] - @month_average[:expense]
    @target = {}
    digits = Math.log10(@balance)
    first_target = (@balance / (10 ** digits.floor) + 1).floor * 10 ** digits.floor
    @target[first_target] = @latest.advance(:months => ((first_target - @balance) / @month_increment).round)
    next_target = 10 ** (Math.log10(first_target).floor + 1)
    @target[next_target] = @latest.advance(:months => ((next_target - @balance) / @month_increment).round)
    
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
    @month_balance[month.prev_month] = 0
    while month <= last do
      this_month = Record.where("day >= ? AND day < ?", month, month.next_month)
      @month_income[month]  = this_month.sum(:income)
      @month_expense[month] = this_month.sum(:expense)
      @month_balance[month] = @month_balance[month.prev_month] + @month_income[month] - @month_expense[month]
      @income_sum += @month_income[month]
      @expense_sum += @month_expense[month]
      if !@years.include? month.year
        @years << month.year
      end
      month = month.next_month
    end
    @month_average = {}
    @month_average[:income] = @income_sum / @month_income.size
    @month_average[:expense] = @expense_sum / @month_expense.size
    @balance = @income_sum - @expense_sum
  end
  
end
