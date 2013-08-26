#======================================================
# 代码背景介绍:
#
# 公司里有很多雇员，但是雇员根据工作内容的不同被分到不同的部门
# 不同的工作，导致不同的待遇:
#
#    工程师， 随时加班，但没有加班费，只拿死工资，很苦逼
#    销售， 随时加班，但有加班费用， 还有业绩提成
#
#------------------------------------------------------
# 类、变量及方法命名说明：
# Employee 雇员类
# Engineer 工程师类，继承自Employee
# Sales    销售类,  继承自Employee
#
# company    :  公司名称
# pay        :  工资，单位RMB
# pay_type   :  工资发放类型，默认为「月」
# worktime   :  正常工作时间，小时为单位，默认8小时
# overtimes  :  加班的总时间， 小时为单位
# order      :  业绩订单数，
# department :  所属部门
#
# work  方法，表示工作内容
# overtime? 方法， 表示是否加班
# sum_pay 方法， 表示工资结算数目
#
# 此代码用来计算月底员工工资
# 请使用Duck-Typing来重构以下代码， 并增加管理者类
# 管理者类月薪按两月发放，管理sales，按照sales订单收奖金
#======================================================

class Employee
  attr_accessor :company, :pay, :worktime, :overtimes, :order, :department, :pay_type

  def initialize(company, pay, worktime=8, overtimes=0, order=0, pay_type="month", department)
  	@company = company
  	@pay = pay
  	@pay_type = pay_type
  	@worktime = worktime
  	@overtimes = overtimes
  	@order = order
  	@department = department
  end

  def overtime?
    true
  end

  def overtimes=(overtimes)
  	if self.is_a?(Engineer)
  		@overtimes = 0
    elsif self.is_a?(Sales)
      @overtimes = overtimes
    end
  end

  def sum_pay
  	if self.is_a?(Engineer)
  		@pay
  	elsif self.is_a?(Sales)
      @pay + (@order*@pay*0.1) + (@overtimes*@pay/20)
  	end
  end


end


class Engineer < Employee

  def work
  	puts "coding...7x24"
  end

end


class Sales < Employee

  def work
  	puts "sales for production"
  end

end

# 本月工资结算

engineer_foo = Engineer.new("GooDream", 10000, "BD")
sales_bar    = Sales.new("GooDream", 3000, "Sales")

engineer_foo.work
sales_bar.work

engineer_foo.overtimes = 200
sales_bar.overtimes = 20

engineer_foo.order = 0
sales_bar.order = 100


puts engineer_foo.sum_pay
puts sales_bar.sum_pay







