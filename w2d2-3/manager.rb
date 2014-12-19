require_relative "employee.rb"
class Manager < Employee
  attr_accessor :employees

  def initialize(name, title, salary, boss = nil)
    super
    @employees = []
  end

  def bonus(multiplier)
    bonus = total_employee_salary * multiplier
    puts bonus
  end

  def total_employee_salary
    return self.salary if self.employees.empty?
    salaries = 0
    employees.map do |employee|
      if employee.is_a?(Manager)
        salaries += employee.total_employee_salary + employee.salary
      else
        salaries += employee.salary
      end
    end
    salaries
    # if self.boss.nil?
    #   salaries = employees.map do |employee|
    #     employee.total_employee_salary()
    #   end
    # else
    #   salaries = employees.map do |employee|
    #     self.salary + employee.total_employee_salary()
    #   end
    # end
  end

  def add_employee(employee)
    @employees << employee
  end
end

ned = Manager.new("Ned", "Founder", 1_000_000)
darren = Manager.new("Darren", "TA Manager", 78_000, ned)
shawna = Employee.new("Shawna", "TA", 12_000, darren)
david = Employee.new "David", "TA", 10_000, darren

ned.bonus(5) # => 500_000
darren.bonus(4) # => 88_000
david.bonus(3) # => 30_000
