class Phaser < Weapon

  def initialize
    super("Phaser", 50, 30)
  end

  def hit(robot)
    robot.wound(damage, true)
  end

end