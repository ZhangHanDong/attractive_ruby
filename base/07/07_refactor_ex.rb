#======================================================
# 利用Duck-typing重构要点介绍:
#
#    1、变量/方法/参数等命名
#    2、放弃继承
#    3、消除if语句
#
#======================================================
# 重构后的代码：（根据变量的命名来阅读代码）
# 增加了管理者类。


module Employee
  attr_accessor :company_name, :pay_rmb, :department_name, :work_hour, :over_hours, :order_nums,  :pay_month_nums

  PAY_TYPE = "Month"

  def initialize(company_name, pay_rmb, department_name, work_hour=8, over_hours=0, order_nums=0, pay_type="month", pay_month_nums=12 )
  	@company_name = company_name
  	@pay_rmb = pay_rmb
  	@pay_month_nums = pay_month_nums
  	@work_hour = work_hour
  	@over_hours = over_hours
  	@order_nums = order_nums
  	@department_name = department_name
  end

  def over_work?
    true
  end

end

# ==============================
#           Engineer           =
# ==============================
class Engineer
  include Employee

  def work
    puts "coding...7x24"
  end

  def over_hours=(over_hours)
    @over_hours = 0
  end

  def order_nums=(order_nums)
    @order_nums = 0
  end

  def sum_pay_rmb
    @pay_rmb * (@pay_month_nums/12)
  end

end

# ==============================
#           Sales              =
# ==============================
class Sales
  include Employee

  def work
  	puts "sales for production"
  end

  def sum_pay_rmb
    @pay_rmb * (@pay_month_nums/12) + (@order_nums*@pay_rmb*0.1) + (@over_hours*@pay_rmb/20)
  end

end

# ==============================
#           Manager            =
# ==============================
class Manager
  include Employee

  attr_accessor :sale_employees

  def work
    puts "company manager"
  end

  def overtime?
    false
  end

  def pay_month_nums=(pay_month_nums)
    @pay_month_nums = 24
  end

  def sum_pay_rmb
    @pay_rmb * (@pay_month_nums/12) + award_money
  end

  def award_money
    award_money = @sale_employees.inject(0) do |am,sale|
      am += sale.order_nums * 200
    end
  end

  def sale_employees=(employees)
    @sale_employees = employees
  end
end


# 月度工资结算

engineer_foo = Engineer.new("GooDream", 10000, "BD")

sales_bar1    = Sales.new("GooDream", 3000, "Sales")
sales_bar2    = Sales.new("GooDream", 3000, "Sales")
sales_bar3    = Sales.new("GooDream", 3000, "Sales")

sales_bar1.order_nums = 50
sales_bar2.order_nums = 80
sales_bar3.order_nums = 110

manager_coo = Manager.new("GooDream", 2000, "Manager")
manager_coo.sale_employees = [sales_bar1, sales_bar2, sales_bar3]

puts "苦逼的码农发了：#{engineer_foo.sum_pay_rmb} 元"
puts "sales 1， 靠提成发了：#{sales_bar1.sum_pay_rmb} 元"
puts "sales 2， 靠提成发了：#{sales_bar2.sum_pay_rmb} 元"
puts "sale3 3， 靠提成发了：#{sales_bar3.sum_pay_rmb} 元"
puts "不要看管理者基本工资低，管理者实际发放：#{manager_coo.sum_pay_rmb} 元"

puts "就算码农升了薪水 。。。又如何？"

engineer_foo = Engineer.new("GooDream", 15000, "BD")
puts "苦逼的码农发了：#{engineer_foo.sum_pay_rmb} 元"





