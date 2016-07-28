class Batteries < Item

  def initialize
    super("Batteries", 25)
  end

  def recharge(robot)
    robot.charge(25)
  end

end