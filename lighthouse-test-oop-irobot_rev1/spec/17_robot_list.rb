require_relative "spec_helper"

describe Robot do
  
  before :each do
    @robot_1 = Robot.new
    @robot_2 = Robot.new
    @robot_3 = Robot.new
  end

  describe ".list" do

    it "should return all the robots currently instantiated." do
      expect(Robot.list.include? @robot_1).to be true
      expect(Robot.list.include? @robot_2).to be true
      expect(Robot.list.include? @robot_3).to be true
    end

  end

end