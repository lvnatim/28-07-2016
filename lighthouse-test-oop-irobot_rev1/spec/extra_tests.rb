require_relative "spec_helper"

describe Robot do

  before :each do
    @robot = Robot.new
    @box_of_bolts = BoxOfBolts.new
  end
  
  describe "#heal" do

    it "should raise an exception when the robot is dead! (health == 0)" do
      expect(@robot).to receive(:health).once.and_return(0)
      expect { @robot.heal(20) }.to raise_error Robot::RobotAlreadyDeadError
    end

  end

  describe "#attack" do
    
    it "should raise an exception when a robot tries to attack an item!" do
      expect { @robot.attack(@box_of_bolts) }.to raise_error Robot::UnattackableEnemy
    end

  end

end

describe BoxOfBolts do

  before :each do
    @robot = Robot.new
    @box_of_bolts = BoxOfBolts.new
  end

  describe "#feed" do

    it  "should raise an RobotAlreadyDeadError when the robot is already dead!" do
      expect(@robot).to receive(:health).once.and_return(0)
      expect { @box_of_bolts.feed(@robot) }.to raise_error Robot::RobotAlreadyDeadError
    end

  end

end