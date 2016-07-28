require_relative 'spec_helper'

describe Robot do
  
  describe "#scan" do

    it "should return an array of Robots surrounding the robots current tile." do

      robot = Robot.new
      3.times{robot.move_up}
      robot_2 = Robot.new
      4.times{robot_2.move_up}
      expect(robot_2.scan.include? robot).to be true

    end

  end

end