class Robot

  class RobotAlreadyDeadError < StandardError
  end

  class UnattackableEnemy < StandardError
  end

  INITIAL_X_POSITION = 0
  INITIAL_Y_POSITION = 0
  MOVEMENT_DISTANCE = 1
  MAXIMUM_CARRY_WEIGHT = 250
  DEFAULT_SHIELD_POINTS = 50
  DEFAULT_ATTACK_DAMAGE = 5
  DEFAULT_ATTACK_RANGE = 1

  @@list = []

  attr_reader :position, :items, :health, :shields
  attr_accessor :equipped_weapon

  def initialize
    @position = [INITIAL_X_POSITION,INITIAL_Y_POSITION]
    @items = []
    @shields = 50
    @health = 100
    @equipped_weapon = nil
    @@list << self
  end

  def move_left
    @position[0] -= MOVEMENT_DISTANCE
  end

  def move_right
    @position[0] += MOVEMENT_DISTANCE
  end

  def move_up
    @position[1] += MOVEMENT_DISTANCE
  end

  def move_down
    @position[1] -= MOVEMENT_DISTANCE
  end

  def pick_up(item)
    return nil if items_weight + item.weight > MAXIMUM_CARRY_WEIGHT
    self.equipped_weapon = item if item.is_a?(Weapon)

    if item.is_a?(BoxOfBolts) && health <= 80
      item.feed(self)
    else
      @items.push(item)
    end
  end

  def items_weight
    @items.inject(0) { |total_weight, item|  total_weight += item.weight }
  end

  def wound(damage)
    if shields > 0
      @shields -= damage
      if shields < 0
        @health += shields
        @shields = 0
      end
    else
      @health -= damage
    end
    @health = 0 if health < 0
  end

  def heal(points)
    raise RobotAlreadyDeadError, "Robot can not be revived if dead!" if self.dead?
    @health += points
    @health = 100 if @health > 100
  end

  def charge(points)
    @shields += points
  end

  # TODO: Currently the attack/check attack methods check if the equipped weapon isn't nil. 
  # In the future, we will implement a default weapon called "claws" which represents the current nil weapon value
  # Unfortunately, the test code makes it so that a unequipped robot must have a nil value for its weapon
  # And I want to avoid changing test code as the premise of this test is to write code to fulfill the tests

  def attack(target)
    raise UnattackableEnemy, "Only robots can be attacked by other robots!" unless target.is_a? Robot
    return nil unless close_enough_to_attack?(target)
    unless equipped_weapon
      target.wound(DEFAULT_ATTACK_DAMAGE)
    else
      equipped_weapon.hit(target)
      if equipped_weapon.is_a?(Grenade)
        @items.delete_at(@items.index(equipped_weapon))
        self.equipped_weapon = nil
      end
    end
  end

  def close_enough_to_attack?(target)
    unless equipped_weapon
      range = DEFAULT_ATTACK_RANGE 
    else
      range = equipped_weapon.range
    end
    x_distance = self.position[0] - target.position[0]
    y_distance = self.position[1] - target.position[1]
    return true if x_distance.abs + y_distance.abs <= range
    false
  end

  def scan
    robots_nearby = []
    robots_nearby += Robot.in_position(position[0] + 1, position[1])
    robots_nearby += Robot.in_position(position[0] - 1, position[1])
    robots_nearby += Robot.in_position(position[0], position[1] + 1)
    robots_nearby += Robot.in_position(position[0], position[1] - 1)
    robots_nearby
  end

  def dead?
    health == 0
  end

  class << self

    def list
      @@list
    end

    def in_position(x,y)
      @@list.select { | robot | robot.position[0] == x && robot.position[1] == y }
    end

  end

end
















