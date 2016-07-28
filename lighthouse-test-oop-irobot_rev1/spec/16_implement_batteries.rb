require_relative "spec_helper"

describe Batteries do

  before :each do
    @robot = Robot.new
    @batteries = Batteries.new
  end
  
  describe ".new" do

    it "should have a name of batteries and a weight of 25" do
      expect(@batteries.name).to eq "Batteries"
      expect(@batteries.weight).to eq 25
    end

  end

  describe "#recharge" do

    it "should raise shields on a robot" do
      @robot.wound(50)
      @batteries.recharge(@robot)
      expect(@robot.shields).to eq(25)
    end

  end

end