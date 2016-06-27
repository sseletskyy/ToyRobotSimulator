require_relative '../toy_robot'
RSpec.describe ToyRobot do
    let(:toy) {ToyRobot.new}
    context 'REPORT' do
        it 'should return empty string when the robot is not placed yet' do
            expect(toy.report).to eq("")
        end
    end

end