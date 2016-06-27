require_relative '../toy_robot'
RSpec.describe ToyRobot do
    it 'should exist' do
        expect(ToyRobot.new).to be_truthy
    end
end