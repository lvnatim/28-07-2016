require_relative "spec_helper"

describe Robot do

  describe ".in_position" do

    it "should return all the robots in a given position." do
      robot = Robot.new
      5.times { robot.move_up }
      expect(Robot.in_position(0, 5)).to eq([robot])
      expect(Robot.in_position(0, 0).include? robot).to be false
    end

  end

end