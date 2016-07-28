require_relative "spec_helper"

describe Phaser do
  
  describe "#hit" do

    it "ignores shields when damaging robots." do

      robot_1 = Robot.new
      phaser = Phaser.new
      phaser.hit(robot_1)
      expect(robot_1.health).to eq(70)
      expect(robot_1.shields).to eq(50)

    end

  end

end