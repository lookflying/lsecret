# encoding: utf-8
module RecordsHelper
  def mask(data)
    if data.is_a? ActiveRecord::Relation
      data.each do |row|
      row.day = mask(row.day)
      row.item = mask(row.item)
      row.expense = mask(row.expense)
      row.income = mask(row.income)
      row.tag = mask(row.tag)
      row.remark = mask(row.remark)
      end
      return data
    else
      str = data.to_s
      str.gsub!(/\p{Word}/, '*') 
      if str.length > 10
        str = str[0, 9]
      end
      return str
    end
  end
end

