class Weapon < Item

  DEFAULT_WEAPON_RANGE = 1

  attr_reader :damage, :range

  def initialize(name, weight, damage, range=DEFAULT_WEAPON_RANGE)
    super(name, weight)
    @damage = damage
    @range = range
  end

  def hit(robot)
    robot.wound(damage)
  end

end