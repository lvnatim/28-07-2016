require_relative "spec_helper"

describe Robot do

  before :each do
    @robot = Robot.new
    @robot_2 = Robot.new
    @laser = Laser.new
    @plasma_cannon = PlasmaCannon.new
  end
  
  describe "#shields" do

    it "should initialize at 50 shield points" do
      expect(@robot.shields).to eq(50)
    end

    it "should take damage before health points" do
      @robot.pick_up(@laser)
      @robot.attack(@robot_2)
      expect(@robot_2.shields).to eq(25)
      expect(@robot_2.health).to eq(100)
    end

    it "should allow damage through if shields are at 0" do
      @robot.pick_up(@plasma_cannon)
      @robot.attack(@robot_2)
      expect(@robot_2.shields).to eq(0)
      expect(@robot_2.health).to eq(95)
    end

  end

end